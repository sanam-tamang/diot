
import 'package:devmandu/core/widgets/shimmer.dart';
import 'package:flutter/material.dart';

import '../enum/loading_type.dart';



class CustomCircularProgressIndicator extends StatelessWidget {
  const CustomCircularProgressIndicator({
    super.key,
    this.type = LoadingType.normal,
  });
  final LoadingType type;
  @override
  Widget build(BuildContext context) {
    if (type == LoadingType.profile) {
      return const Center(child: CircularProgressIndicator());
    } else if (type == LoadingType.article) {
      return const ShimmerLoadingArticle();
    } else if (type == LoadingType.comment) {
      return const ShimmerCommet();
    }else{
      return const Center(child: CircularProgressIndicator());
    }
  }
}
