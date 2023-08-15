import 'package:flutter/material.dart';

class NoArticleMessage extends StatelessWidget {
  const NoArticleMessage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              image: const DecorationImage(
                  fit: BoxFit.contain,
                  image: AssetImage(
                    'assets/images/no_data.png',
                  )),
            ),
          ),
        ),
        Flexible(
          child: Text(
            "No articles has been added",
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: Colors.black),
          ),
        ),
      ],
    );
  }
}
