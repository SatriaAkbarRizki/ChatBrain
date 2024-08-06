import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: SvgPicture.asset(
            'assets/illustration/Search.svg',
            width: MediaQuery.of(context).size.width / 1.1,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Asking About: ',
                style: TextStyle(fontSize: 18, fontFamily: 'Satoshi'),
              ),
              DefaultTextStyle(
                  style: const TextStyle(fontSize: 18, fontFamily: 'Satoshi'),
                  child: AnimatedTextKit(
                      isRepeatingAnimation: true,
                      repeatForever: true,
                      
                      animatedTexts: [
                        TypewriterAnimatedText('Food',
                            speed: const Duration(milliseconds: 200)),
                        TypewriterAnimatedText('History',
                            speed: const Duration(milliseconds: 200)),
                        TypewriterAnimatedText('Programming',
                            speed: const Duration(milliseconds: 200)),
                        TypewriterAnimatedText('Healthing',
                            speed: const Duration(milliseconds: 200)),
                        TypewriterAnimatedText('More...',
                            speed: const Duration(milliseconds: 200))
                      ]))
            ],
          ),
        )
      ],
    );
  }
}
