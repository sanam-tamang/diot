// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:devmandu/core/config/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomCacheNetworkImage extends StatefulWidget {
  const CustomCacheNetworkImage({
    Key? key,
    this.imageUrl,
    this.fit = BoxFit.contain,
  }) : super(key: key);
  final String? imageUrl;
  final BoxFit fit;

  @override
  State<CustomCacheNetworkImage> createState() =>
      _CustomCacheNetworkImageState();
}

class _CustomCacheNetworkImageState extends State<CustomCacheNetworkImage> {
  late final AssetImage placeHolderLoadingImage;
  
  @override
  void initState() {
    placeHolderLoadingImage =
        const AssetImage("assets/images/image_loading_placeholder.png");
    super.initState();
  }

  @override
  void didChangeDependencies() {
    precacheImage(placeHolderLoadingImage, context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return widget.imageUrl != null
        ? FadeInImage(
            fit: widget.fit,
            image: CachedNetworkImageProvider(widget.imageUrl!),
            placeholder: placeHolderLoadingImage,
            imageErrorBuilder: (context, url, error) =>
                const Center(child: Icon(Icons.error)),
          )
        : Container(
            color: AppColors.greyScale7,
          );
  }
}
