import 'package:flutter/material.dart';

class OnBoarding5 extends StatelessWidget {
  const OnBoarding5({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: const Center(
        child: Image(
          image: AssetImage("assets/images/onboarding_screen_5.png"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
