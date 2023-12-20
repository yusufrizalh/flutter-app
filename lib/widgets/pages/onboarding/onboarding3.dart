import 'package:flutter/material.dart';

class OnBoarding3 extends StatelessWidget {
  const OnBoarding3({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: const Center(
        child: Image(
          image: AssetImage("assets/images/onboarding_screen_3.png"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
