// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:devmandu/core/config/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/config/size.dart';

class CommentButton extends StatelessWidget {
  const CommentButton({
    Key? key,
    this.onPressed,
    required this.commentCount,
  }) : super(key: key);
  final VoidCallback? onPressed;
  final int commentCount;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
            onTap: onPressed,
            child:const  FaIcon(
              FontAwesomeIcons.solidComment,
              color: AppColors.articleFooterActionsDefaultColor,
              size: footerArticleIconSize,
            )),
        const SizedBox(
          width: 3,
        ),
        Text(
          commentCount.toString(),
          style:const  TextStyle(color: AppColors.articleFooterActionsDefaultColor),
        ),
      ],
    );
  }
}
