
import 'package:flutter/material.dart';

import '../enum/hero_tag_type.dart';
import '../utils/hero_builder.dart';
///
/// [HeroBuilder] will help to show tag uniquely
/// hero builder is worked with [CustomHeroWidget] only it doesnot have to do any other thing
/// 
class CustomHeroWidget extends StatelessWidget {
  const CustomHeroWidget({
    super.key,
    required this.tag,
    required this.payload,
    required this.child,
  });
  final HeroTagType tag;
  final String payload;
  final Widget child;
  @override
  Widget build(BuildContext context) {
  
    return tag == HeroTagType.noAnimation
        ? child
        : Hero(
            transitionOnUserGestures: true,
            tag: HeroBuilder.getTag(tag: tag, payload: payload),
            child: child,
          );
  }
}
