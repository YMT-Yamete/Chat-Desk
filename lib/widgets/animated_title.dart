import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class AnimatedTitle extends StatelessWidget {
  const AnimatedTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 14),
      child: AnimatedTextKit(
        animatedTexts: [
          TyperAnimatedText(
            'Photo Scrapbook',
            textStyle: const TextStyle(
              fontSize: 35.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'SourceSansPro',
            ),
            speed: const Duration(milliseconds: 100),
          ),
        ],
        totalRepeatCount: 4,
        pause: const Duration(milliseconds: 5000),
        displayFullTextOnTap: true,
        stopPauseOnTap: true,
      ),
    );
  }
}