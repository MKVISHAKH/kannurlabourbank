import 'package:flutter/material.dart';

class Backgroundsplash extends StatelessWidget {
  const Backgroundsplash({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => const LinearGradient(
        colors: [Colors.black, Colors.black12],
        begin: Alignment.bottomCenter,
        end: Alignment.center,
      ).createShader(bounds),
      blendMode: BlendMode.lighten,
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                // 'assets/splash/images22.jpg',
                'assets/splash/splash2.jpg'
                //'assets/backgroundimg/indian rupees.jpg',
                ),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.white12, BlendMode.darken),
          ),
        ),
      ),
    );
  }
}
