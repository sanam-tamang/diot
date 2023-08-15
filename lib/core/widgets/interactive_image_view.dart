import 'hero_widget.dart';
import 'package:flutter/material.dart';

import '../enum/hero_tag_type.dart';
import 'custom_cache_network_image.dart';

class InteractiveImageViewerPage extends StatelessWidget {
  const InteractiveImageViewerPage({
    Key? key,
    required this.imageUrl,
    required this.tag,
  }) : super(key: key);
  final String imageUrl;

  ///if you doesnot want hero animation you could skip this
  final HeroTagType? tag;

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      child: Scaffold(
        backgroundColor: Colors.black,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: _buildBackButtton(context),
        ),
        body: _buildInteractiveViewerImage(),
      ),
    );
  }

  Widget _buildInteractiveViewerImage() {
    return SafeArea(
      child: Center(
          child: CustomHeroWidget(
        tag: tag ?? HeroTagType.noAnimation,
        payload: imageUrl,
        child: CustomCacheNetworkImage(
          imageUrl: imageUrl,
        ),
      )),
    );
  }

  IconButton _buildBackButtton(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: const Icon(
          Icons.close,
          color: Colors.white,
          size: 32,
        ));
  }
}
