import 'package:flutter/material.dart';
import 'package:psychic_trainer/screens/riveSandbox/widgets/main_card.dart';
import 'package:rive/rive.dart' as rive;

class RiveSandboxScreen extends StatelessWidget {
  const RiveSandboxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: const Center(child: SizedBox(child: MainCard())));
  }
}
