import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoadingArticle extends StatelessWidget {
  const ShimmerLoadingArticle({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          enabled: true,
          child: ListView(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: const [
              TitlePlaceholder(),
              BodyPlaceholder(
                height: 150,
              ),
              SizedBox(
                height: 35,
              ),
              TitlePlaceholder(),
              BodyPlaceholder(
                height: 250,
              ),
              SizedBox(
                height: 35,
              ),
            ],
          )),
    );
  }
}

class ShimmerCommet extends StatelessWidget {
  const ShimmerCommet({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        body: Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            enabled: true,
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  buildTitle(context),
                  buildCommentContent(120),
                  buildTitle(context),
                  buildCommentContent(80),
                  buildTitle(context),
                  buildCommentContent(200),
                  buildTitle(context),
                  buildCommentContent(60),
                ],
              ),
            )),
      ),
    );
  }

  Widget buildTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          const Flexible(
            child: CircleAvatar(
              radius: 30,
            ),
          ),
          Flexible(
            child: Container(
              height: 40,
              color: Colors.white,
              width: MediaQuery.of(context).size.width * 0.4,
            ),
          ),
          Flexible(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
              height: 10,
              width: 60,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCommentContent(double height) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8).copyWith(bottom: 20),
      color: Colors.white,
      width: double.maxFinite,
      height: height,
    );
  }
}

class TitlePlaceholder extends StatelessWidget {
  const TitlePlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 30,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 40,
                    color: Colors.white,
                    width: double.maxFinite,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    height: 10,
                    width: 150,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BodyPlaceholder extends StatelessWidget {
  const BodyPlaceholder({
    Key? key,
    required this.height,
  }) : super(key: key);
  final double height;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          color: Colors.white,
          width: double.maxFinite,
          height: height,
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              color: Colors.white,
              width: 60,
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              color: Colors.white,
              width: 60,
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              color: Colors.white,
              width: 60,
              height: 10,
            ),
          ],
        )
      ],
    );
  }
}
