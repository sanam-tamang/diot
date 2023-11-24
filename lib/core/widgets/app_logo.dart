// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class AppLogo extends StatefulWidget {
  const AppLogo({
    super.key,
    this.center = false,
  });
  final bool center;
  @override
  State<AppLogo> createState() => _AppLogoState();
}

class _AppLogoState extends State<AppLogo> {
  late final Image logo;
  @override
  void initState() {
    logo = Image.asset("assets/icons/logo.png");
    super.initState();
  }

  @override
  void didChangeDependencies() {
    precacheImage(logo.image, context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Row(
        mainAxisAlignment:
            widget.center ? MainAxisAlignment.center : MainAxisAlignment.start,
        children: [
          logo,
          const AutoSizeText(
            'Diot',
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }
}
