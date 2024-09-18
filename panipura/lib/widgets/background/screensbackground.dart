import 'package:flutter/material.dart';

class Screensbackground extends StatelessWidget {
  const Screensbackground({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => const LinearGradient(
        colors: [Colors.transparent, Colors.transparent],
        begin: Alignment.bottomCenter,
        end: Alignment.center,
      ).createShader(bounds),
      blendMode: BlendMode.lighten,
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/background/11032570.jpg',
            ),
            fit: BoxFit.cover,
            opacity: 1,
            colorFilter: ColorFilter.mode(Colors.white12, BlendMode.darken),
          ),
        ),
      ),
    );
  }
}
