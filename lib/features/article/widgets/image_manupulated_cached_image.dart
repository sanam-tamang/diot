import 'package:flutter/material.dart';

import '../../../core/widgets/custom_cache_network_image.dart';

class ManupulatedCachedNetworkImage extends StatelessWidget {
  const ManupulatedCachedNetworkImage({
    super.key,
    required this.imageUrl,
    this.borderRadius = 16,
  });
  final String? imageUrl;
  final double borderRadius;
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Stack(
      children: [
        // Your original image
        imageUrl != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(borderRadius),
                child: CustomCacheNetworkImage(
                  imageUrl: imageUrl,
                ),
              )
            : const SizedBox.shrink(),
        // Black overlay at the bottom
        imageUrl != null
            ? Positioned.fill(
                bottom: 0,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(borderRadius),
                    gradient: const LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black38,
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              )
            : const SizedBox.shrink(),
      ],
    ));
  }
}
