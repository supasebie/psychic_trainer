import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class MainCard extends StatefulWidget {
  const MainCard({super.key});

  @override
  State<MainCard> createState() => _MainCardState();
}

class _MainCardState extends State<MainCard> {
  // To store the StateMachineController if you need to interact with it later,
  // though for a direct listener, you might not need to store it.
  StateMachineController? _stateMachineController;
  SMITrigger? _flipTriggerInput; // To store the Rive trigger input

  @override
  void initState() {
    super.initState();
  }

  void _onRiveInit(Artboard artboard) {
    const String stateMachineName = 'FlipCard';
    var controller = StateMachineController.fromArtboard(
      artboard,
      stateMachineName,
    );

    if (controller != null) {
      artboard.addController(controller);
      _stateMachineController = controller; // Store it if needed
      _flipTriggerInput = controller.getTriggerInput('Click');

      print(
        "'$stateMachineName' state machine initialized and added to artboard '${artboard.name}'.",
      );

      // Since your Rive listener (from the screenshot) directly handles the click
      // to transition states, you typically DON'T need to find and fire an SMIInput here.
      // The Rive runtime will handle the tap event passed by Flutter's GestureDetector.
    } else {
      print(
        "Error: Could not find or initialize StateMachineController named '$stateMachineName' on artboard '${artboard.name}'. "
        "Please verify names in your Rive editor and Flutter code.",
      );
    }
  }

  @override
  void dispose() {
    _stateMachineController
        ?.dispose(); // Dispose of the controller when the widget is removed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 320,
                height: 480,
                child: RiveAnimation.asset(
                  'assets/animations/better_card_flip.riv', // Your Rive file
                  artboard: 'card_base', // Correct artboard name
                  fit: BoxFit.cover, // Or BoxFit.contain as you had previously
                  onInit: _onRiveInit, // Initialize the Rive animationRE
                ),
              ),
              const SizedBox(
                height: 20,
              ), // Add spacing between the animation and the button
              ElevatedButton(
                onPressed: () {
                  // Add your button logic here
                  _flipTriggerInput?.fire(); // Trigger the flip animation
                },
                child: const Text('Flip The Card'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
