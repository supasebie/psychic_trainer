import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:psychic_trainer/screens/riveSandbox/widgets/main_card.dart';
import 'package:rive/rive.dart' as rive;

class RiveSandboxScreen extends StatelessWidget {
  const RiveSandboxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // return Scaffold(body: const Center(child: SizedBox(child: MainCard())));
    return Scaffold(
      body: Stack(
        children: [
          // Background Layer: Rive Animation
          const rive.RiveAnimation.asset(
            "assets/animations/breathing.riv", // Your Rive animation file
            fit: BoxFit.cover, // Ensure it covers the entire Stack area
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 30, // Horizontal blur
                sigmaY: 30, // Vertical blur
              ),
              child: const SizedBox(child: MainCard()),
            ),
          ), // Needs a child, even if it's empty
          // Top Layer: Your Main Content
        ],
      ),
    );
  }
}
