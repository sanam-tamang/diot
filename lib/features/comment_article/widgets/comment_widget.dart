
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../../core/config/theme/app_colors.dart';
import '../../../core/utils/custom_circualr_dialog.dart';
import '../../../core/utils/toast_message.dart';
import '../../article/models/article.dart';
import '../blocs/article_comment_cud/article_comment_cud_cubit.dart';
import '../model/comment_model.dart';

class CommentWidget extends StatefulWidget {
  const CommentWidget(
      {super.key,
      required this.article,
      this.autoFocusCommentField = false,
      this.pop = false});
  final GetArticle article;
  final bool autoFocusCommentField;

  ///this only for from if [CommentWidget] is wrap by bottomsheet or dialog
  final bool pop;

  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  late TextEditingController controller;
  final borderRadius = BorderRadius.circular(15);

  @override
  void initState() {
    controller = TextEditingController();
    controller.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ArticleCommentCudCubit, ArticleCommentCudState>(
      listener: (context, state) {
        if (state is ArticleCommentCudLoading) {
          circularLoadingDialog(context);
        } else if (state is ArticleCommentCudFailure) {
           toastMessage(content: state.message);
          Navigator.of(context).pop();
           widget.pop ? Navigator.of(context).pop() : null;
         
        } else if (state is ArticleCommentCudSuccess) {
          toastMessage(content: state.message);
          Navigator.of(context).pop();
           widget.pop ? Navigator.of(context).pop() : null;
          controller.clear();
          
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                    color: AppColors.greyScale7, borderRadius: borderRadius),
                child: TextFormField(
                  controller: controller,
                  autofocus: widget.autoFocusCommentField,
                  maxLines: 3,
                  minLines: 1,
                  decoration: InputDecoration(
                      suffixIcon: _sendButton(),
                      enabledBorder: _outlineBorder(Colors.black26),
                      focusedBorder:
                          _outlineBorder(Theme.of(context).colorScheme.primary),
                      hintText: "Add your comment..."),
                ),
              ),
            ),
          ],
        ),
      ),
    
    
    
    );
  }

  Widget _sendButton() {
    return BlocBuilder<ArticleCommentCudCubit, ArticleCommentCudState>(
      builder: (context, state) {
        return IconButton(
            onPressed:
                controller.text.trim().isEmpty  || state is ArticleCommentCudLoading
                    ? null
                    : __createComment,
            icon: Icon(
              Icons.send,
              color:
                  controller.text.trim().isEmpty  || state is ArticleCommentCudLoading
                      ? AppColors.primary.withOpacity(0.3)
                      : AppColors.primary,
            ));
      },
    );
  }

  void __createComment() {
    CreateComment comment = CreateComment(
        articleId: widget.article.id,
        commentId: const Uuid().v4(),
        content: controller.text,
        timestamp: Timestamp.now());
    context.read<ArticleCommentCudCubit>().createArticleComment(comment);
   
  }

  InputBorder _outlineBorder(Color color) {
    return InputBorder.none;
    // return OutlineInputBorder(
    //     borderRadius: borderRadius, borderSide: BorderSide(color: color));
  }
}
