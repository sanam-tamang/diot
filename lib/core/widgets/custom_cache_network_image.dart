// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:devmandu/core/config/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomCacheNetworkImage extends StatelessWidget {
  const CustomCacheNetworkImage({
    super.key,
    this.imageUrl,
    this.fit = BoxFit.contain,
  });
  final String? imageUrl;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return imageUrl != null
        ? CachedNetworkImage(
            fit: fit,
            imageUrl: imageUrl!,
            placeholder: (context, url) => Container(
              color: Colors.grey.shade200,
            ),
            errorWidget: (context, url, error) =>
                const Center(child: Icon(Icons.error)),
          )
        : Container(
            color: AppColors.greyScale7,
          );
  }
}
