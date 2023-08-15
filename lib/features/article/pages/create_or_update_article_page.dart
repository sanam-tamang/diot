// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;

import 'package:devmandu/core/utils/custom_circualr_dialog.dart';
import 'package:devmandu/core/utils/image_picker.dart';
import 'package:devmandu/core/utils/toast_message.dart';
import 'package:devmandu/features/article/blocs/article_cud_cubit/article_cud_cubit.dart';
import 'package:devmandu/features/article/models/article.dart';

import '../../../core/utils/dialog_message.dart';
import '../../../core/widgets/custom_elevated_button.dart';
import '../../../core/widgets/show_local_image_file.dart';
import '../blocs/toolbar_visibility/quil_toolbar_visibibility_cubit.dart';
import '../widgets/custom_quill_editor.dart';

class CreateOrUpdateArticlePage extends StatefulWidget {
  const CreateOrUpdateArticlePage({
    Key? key,
    this.article,
  }) : super(key: key);
  final GetArticle? article;
  @override
  State<CreateOrUpdateArticlePage> createState() =>
      _CreateOrUpdateArticlePageState();
}

class _CreateOrUpdateArticlePageState extends State<CreateOrUpdateArticlePage> {
  late final TextEditingController _titleController;
  late final quill.QuillController _contentController;
  late final FocusNode _titleFocus;
  late final FocusNode _contentFocus;
  Uint8List? imageFile;
  late final ArticleCudCubit _articleCudCubit;
  @override
  void initState() {
    _titleController = TextEditingController(text: widget.article?.title ?? "");
    _contentController = quill.QuillController(
      keepStyleOnNewLine: true,
      selection: const TextSelection.collapsed(offset: 0),
      document: widget.article?.content == null
          ? quill.Document()
          : quill.Document.fromJson(
              jsonDecode(widget.article!.content.toString())),
    );

    _articleCudCubit = BlocProvider.of<ArticleCudCubit>(context);

    _titleFocus = FocusNode();
    _contentFocus = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    _contentController.dispose();
    _titleController.dispose();
    _titleFocus.dispose();
    _contentFocus.dispose();
    // _articleCudCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _articleCudCubit,
      child: Scaffold(
          body: SafeArea(
            child: BlocListener<ArticleCudCubit, ArticleCudState>(
              listener: (context, state) {
                if (state is ArticleCudLoading) {
                  circularLoadingDialog(context);
                } else if (state is ArticleCudSuccess) {
                  toastMessage(content: state.message);

                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                } else if (state is ArticleCudFailure) {
                  toastMessage(content: state.message);

                  Navigator.of(context).pop();
                }
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      actions: [
                        widget.article == null
                            ? CustomElevatedButton(
                                label: "Publish",
                                onPressed: _createArticle,
                              )
                            : CustomElevatedButton(
                                label: "Update",
                                onPressed: _updateArticle,
                              )
                      ],
                    ),
                    SliverToBoxAdapter(child: _buildTitleTextField()),
                    // SliverToBoxAdapter(child: _buildQuillToolbar()),
                    SliverToBoxAdapter(child: _buildQuillEditor()),

                    SliverToBoxAdapter(
                        child: widget.article != null
                            ? const SizedBox.shrink()
                            : _buildImagePickerWidget()),
                  ],
                ),
              ),
            ),
          ),
          bottomSheet: MediaQuery.of(context).viewInsets.bottom > 0
              ? _buildQuillToolbar()
              : const SizedBox.shrink()),
    );
  }

  StatefulBuilder _buildImagePickerWidget() {
    return StatefulBuilder(builder: (context, localSetState) {
      return Padding(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewPadding.bottom + 100),
        child: Column(
          children: [
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: () async {
                      await CustomPicker.imageFile().then((value) {
                        localSetState(() {
                          imageFile = value;
                        });
                      });
                    },
                    icon: const Icon(Icons.photo))
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: ShowLocalImageFile(
                imageFile: imageFile,
                deleteImage: () {
                  localSetState(() {
                    imageFile = null;
                  });
                },
              ),
            )
          ],
        ),
      );
    });
  }

  Widget _buildTitleTextField() {
    return BlocBuilder<QuilToolbarVisibibilityCubit,
        QuilToolbarVisibibilityState>(
      builder: (context, state) {
        return TextFormField(
          onTap: () => context
              .read<QuilToolbarVisibibilityCubit>()
              .changeVisibility(false),
          focusNode: _titleFocus,
          maxLength: 35,
          maxLines: 2,
          minLines: 1,
          keyboardType: TextInputType.multiline,
          textCapitalization: TextCapitalization.words,
          controller: _titleController,
          style: Theme.of(context).textTheme.headlineMedium,
          decoration: const InputDecoration.collapsed(hintText: 'Title'),
        );
      },
    );
  }

  Widget _buildQuillEditor() {
    return BlocBuilder<QuilToolbarVisibibilityCubit,
        QuilToolbarVisibibilityState>(
      builder: (context, state) {
        return Container(
            height: 220,
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: CustomQuillEditor(
              onTap: () => context
                  .read<QuilToolbarVisibibilityCubit>()
                  .changeVisibility(true),

              focusNode: _contentFocus,
              controller: _contentController,
              // showCursor: state.isKeyboardVisibile,
              hintText: 'Content',
            ));
      },
    );
  }

  Widget _buildQuillToolbar() {
    return Builder(builder: (context) {
      return BlocBuilder<QuilToolbarVisibibilityCubit,
          QuilToolbarVisibibilityState>(
        builder: (context, state) {
          return Container(
            color: Colors.grey.shade100,
            padding: const EdgeInsets.only(top: 2, right: 4)
                .copyWith(bottom: MediaQuery.of(context).viewPadding.bottom),
            child: Visibility(
              visible: state.isKeyboardVisibile,
              child: quill.QuillToolbar.basic(
                controller: _contentController,
                multiRowsDisplay: false,
                showRedo: false,
                showUndo: false,
                showLink: false,
                showSearchButton: false,
                showSubscript: false,
                showSuperscript: false,
                showInlineCode: false,
                showListNumbers: false,
                showFontSize: false,
              ),
            ),
          );
        },
      );
    });
  }

  void _createArticle() {
    final plainContent = _contentController.document.toPlainText();
    final content = jsonEncode(_contentController.document.toDelta().toJson());
    final title = _titleController.text;
    if (plainContent.length <= 1 && title.isEmpty) {
      dialogMessage(context,
          title: 'Validation failed',
          content: "Title or content both can't be null");
      return;
    }

    _articleCudCubit.create(
        CreateArticle(title: title, content: content, imageFile: imageFile));
  }

  void _updateArticle() {
    final plainContent = _contentController.document.toPlainText();
    final content = jsonEncode(_contentController.document.toDelta().toJson());
    final title = _titleController.text;
    if (plainContent.length <= 1 && title.isEmpty) {
      dialogMessage(context,
          title: 'Validation failed',
          content: "Title or content both can't be null");
      return;
    }

    _articleCudCubit.updateArticle(widget.article!.id,
        article: CreateArticle(
          title: title,
          content: content,
        ));
  }
}
