import 'package:flutter/material.dart';

class OnBoarding1 extends StatelessWidget {
  const OnBoarding1({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: const Center(
        child: Image(
          image: AssetImage("assets/images/onboarding_screen_1.png"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
