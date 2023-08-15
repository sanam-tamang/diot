// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:devmandu/core/widgets/shimmer.dart';
import 'package:flutter/material.dart';

import '../enum/loading_type.dart';



class CustomCircularProgressIndicator extends StatelessWidget {
  const CustomCircularProgressIndicator({
    Key? key,
    this.type = LoadingType.normal,
  }) : super(key: key);
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
