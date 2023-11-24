// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:devmandu/core/config/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:like_button/like_button.dart' as btn;

import '../../../core/config/size.dart';
import '../bloc/article_like_cubit/article_like_cubit.dart';

class LikeButton extends StatelessWidget {
  const LikeButton({
    super.key,
    required this.onPressed,
    required this.isLiked,
    required this.likeCount,
  });
  final VoidCallback? onPressed;
  final bool isLiked;
  final int likeCount;


  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArticleLikeCubit, ArticleLikeState>(
      builder: (context, state) {
        if (state is ArticleLikeInitial) {
          return _button(onPressed, likeCount);
        }
        //disabling the button
        return _button(null, likeCount);
      },
    );
  }

  Widget _button(VoidCallback? onPressed, int likeCount) {
    final color = isLiked? Colors.red: AppColors.articleFooterActionsDefaultColor;
    return Row(
      children: [
        btn.LikeButton(
          likeBuilder: (bool isLiked) {
            return FaIcon(
              FontAwesomeIcons.solidHeart,
              color: color,
              size: footerArticleIconSize,
            );
          },
          onTap: (isLiked) async {
            onPressed == null ? null : onPressed();
            return !isLiked;
          },
          isLiked: isLiked,
          size: footerArticleIconSize,
          countPostion: btn.CountPostion.right,
          // countDecoration: (count, likeCount) {

          // },

          likeCount: likeCount,
          countBuilder: (likeCount, isLiked, text) {
            
            Widget result;

            result = Text(
              text,
              style: TextStyle(color: color),
            );

            return result;
          },
        ),
        // Text(likeCount.toString())
      ],
    );
  }
}
