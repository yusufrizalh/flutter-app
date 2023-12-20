import 'package:flutter/material.dart';

class OnBoarding4 extends StatelessWidget {
  const OnBoarding4({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: const Center(
        child: Image(
          image: AssetImage("assets/images/onboarding_screen_4.png"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
