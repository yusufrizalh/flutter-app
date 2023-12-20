import 'package:flutter/material.dart';

class OnBoarding2 extends StatelessWidget {
  const OnBoarding2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: const Center(
        child: Image(
          image: AssetImage("assets/images/onboarding_screen_2.png"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
