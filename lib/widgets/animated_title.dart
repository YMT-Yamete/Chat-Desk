import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class AnimatedTitle extends StatelessWidget {
  const AnimatedTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedTextKit(
      animatedTexts: [
        TypewriterAnimatedText(
          'Photo Scrapbook',
          textStyle: const TextStyle(
            fontSize: 38.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'SourceSansPro',
          ),
          speed: const Duration(milliseconds: 500),
        ),
      ],
      totalRepeatCount: 4,
      pause: const Duration(milliseconds: 500),
      displayFullTextOnTap: true,
      stopPauseOnTap: true,
    );
  }
}