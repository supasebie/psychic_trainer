import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:psychic_trainer/screens/riveSandbox/rivesandbox_screen.dart';
import 'package:psychic_trainer/screens/zenerTest/zener_test_screen.dart';
import 'package:rive/rive.dart' as rive;
import 'widgets/animated_btn.dart';
// import 'components/sign_in_dialog.dart'; // Removed as showCustomDialog is no longer used

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late rive.RiveAnimationController _btnAnimationController;

  // bool showSignIn = false; // Removed as it's no longer needed for dialog

  @override
  void initState() {
    _btnAnimationController = rive.OneShotAnimation("active", autoplay: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            width: MediaQuery.of(context).size.width * 1.7,
            left: 100,
            bottom: 100,
            child: Image.asset("assets/backgrounds/spline.png"),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: const SizedBox(),
            ),
          ),
          const rive.RiveAnimation.asset("assets/riveAssets/shapes.riv"),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
              child: const SizedBox(),
            ),
          ),
          AnimatedPositioned(
            // top: showSignIn ? -50 : 0, // Changed as showSignIn is removed
            top: 0, // Set to 0 as the screen will not shift up anymore
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            duration: const Duration(milliseconds: 260),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(),
                    const SizedBox(
                      width: 260,
                      child: Column(
                        children: [
                          Text(
                            "Master Your Intuition & Focus",
                            style: TextStyle(
                              fontSize: 60,
                              fontWeight: FontWeight.w900,
                              fontFamily: "Poppins",
                              height: 1.2,
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(
                            "Don't let your mind control you. Control your mind. \nPsychic trainer is an application that elucidates the process of learning intuition and focus.",
                          ),
                        ],
                      ),
                    ),
                    const Spacer(flex: 2),
                    AnimatedBtn(
                      btnAnimationController: _btnAnimationController,
                      press: () {
                        _btnAnimationController.isActive = true;

                        Future.delayed(const Duration(milliseconds: 800), () {
                          // setState(() { // Removed: No longer setting showSignIn
                          //   showSignIn = true;
                          // });
                          if (!context.mounted) return;
                          // showCustomDialog(context, onValue: (_) {}); // Removed: No longer showing dialog
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RiveSandboxScreen(),
                            ),
                          );
                        });
                      },
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 24),
                      child: Text(
                        "Sign in to start your journey to the center of your mind. Find access to meditation and prayer practices that will help unlock your potential!",
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
