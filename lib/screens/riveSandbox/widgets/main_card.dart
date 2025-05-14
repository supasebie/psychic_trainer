import 'dart:math';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

int getRandomNumber() {
  final random = Random();

  return random.nextInt(5);
}

int stagger = 1;

class MainCard extends StatefulWidget {
  const MainCard({super.key});

  @override
  State<MainCard> createState() => _MainCardState();
}

class _MainCardState extends State<MainCard> {
  late RiveAnimation anim;
  late StateMachineController? _stateMachineController;

  SMITrigger? _flipTriggerInput;
  SMINumber? _zenerInput;

  @override
  void initState() {
    super.initState();

    anim = RiveAnimation.asset(
      'assets/animations/better_card_flip1.riv',
      fit: BoxFit.contain,
      stateMachines: const ['FlipCard'],
      artboard: 'card_base',
      onInit: _onRiveInit,
    );
  }

  void _onRiveInit(Artboard artboard) {
    var controller = StateMachineController.fromArtboard(artboard, 'FlipCard');

    if (controller != null) {
      artboard.addController(controller);
      _stateMachineController = controller; // Store it if needed
      _flipTriggerInput = controller.getTriggerInput('Click');
      _zenerInput = controller.findInput<double>('ZenerNumber') as SMINumber?;
    }
  }

  @override
  void dispose() {
    _stateMachineController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(child: anim),
        Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 800),
            child: ElevatedButton(
              onPressed: () {
                // Add your button logic here
                stagger = stagger + 1;
                if (stagger % 2 == 0) {
                  _zenerInput?.value = getRandomNumber().toDouble();
                }
                _flipTriggerInput?.fire(); // Trigger the flip animation
              },
              child: const Text('Flip The Card'),
            ),
          ),
        ),
      ],
    );
  }
}
