import 'dart:math'; // For generating random Zener cards
import 'dart:ui'; // Required for ImageFilter.blur
import 'package:flutter/material.dart';
import 'package:rive/rive.dart' as rive; // Required for RiveAnimation

// Enum to represent the Zener card symbols
enum ZenerSymbol { circle, cross, waves, square, star }

// Helper extension to get IconData and Name for each ZenerSymbol
extension ZenerSymbolData on ZenerSymbol {
  IconData get icon {
    switch (this) {
      case ZenerSymbol.circle:
        return Icons.circle_outlined;
      case ZenerSymbol.cross:
        return Icons.add;
      case ZenerSymbol.waves:
        return Icons.waves;
      case ZenerSymbol.square:
        return Icons.crop_square;
      case ZenerSymbol.star:
        return Icons.star_border_outlined;
    }
  }

  String get displayName {
    // Returns the name of the enum value with the first letter capitalized
    String name = toString().split('.').last;
    return name[0].toUpperCase() + name.substring(1);
  }
}

class ZenerTestScreen extends StatefulWidget {
  const ZenerTestScreen({super.key});

  @override
  State<ZenerTestScreen> createState() => _ZenerTestScreenState();
}

class _ZenerTestScreenState extends State<ZenerTestScreen> {
  // List of all possible Zener symbols for user selection
  final List<ZenerSymbol> _selectableSymbols = ZenerSymbol.values;
  // The deck of cards for the current round (e.g., 5 cards to guess)
  List<ZenerSymbol> _deck = [];
  // The current card the user needs to guess from the deck
  ZenerSymbol? _currentTargetCard;
  // Index of the current card being guessed in the _deck
  int _currentDeckIndex = 0;
  // Number of correct guesses in the current round
  int _correctScore = 0;
  // Total number of cards/attempts in a single round
  final int _totalAttemptsInRound = 5;
  // Feedback message to the user (e.g., "Correct!", "Oops!")
  String _feedbackMessage = "";
  // Controls whether the target card's symbol is visible
  bool _showTargetSymbol = false;
  // Indicates if the current round of guessing is over
  bool _roundOver = false;
  // To prevent multiple taps while feedback is shown
  bool _isGuessingDisabled = false;

  @override
  void initState() {
    super.initState();
    _startNewRound(); // Initialize the first round when the screen loads
  }

  // Sets up a new round of the Zener card test
  void _startNewRound() {
    final random = Random();
    setState(() {
      _deck = List.generate(
        _totalAttemptsInRound,
        (_) => ZenerSymbol.values[random.nextInt(ZenerSymbol.values.length)],
      );
      _currentDeckIndex = 0;
      _correctScore = 0;
      _currentTargetCard = _deck[_currentDeckIndex];
      _feedbackMessage = "";
      _showTargetSymbol = false;
      _roundOver = false;
      _isGuessingDisabled = false;
    });
  }

  // Handles the user's guess
  void _handleGuess(ZenerSymbol guessedSymbol) {
    if (_roundOver || _isGuessingDisabled) {
      return; // Do nothing if round is over or guessing is disabled
    }

    setState(() {
      _isGuessingDisabled = true; // Disable further guesses temporarily
      _showTargetSymbol = true; // Reveal the target card

      if (guessedSymbol == _currentTargetCard) {
        _correctScore++;
        _feedbackMessage = "Correct!";
      } else {
        _feedbackMessage =
            "Oops! The card was ${_currentTargetCard?.displayName ?? 'N/A'}.";
      }

      // Check if the round is over
      if (_currentDeckIndex >= _totalAttemptsInRound - 1) {
        _roundOver = true;
        _feedbackMessage +=
            "\nRound Over! Score: $_correctScore / $_totalAttemptsInRound";
        // Re-enable guessing for the "Play Again" button or if the user navigates away and back
        Future.delayed(const Duration(milliseconds: 500), () {
          if (mounted) {
            setState(() {
              _isGuessingDisabled = false;
            });
          }
        });
      } else {
        // Move to the next card after a delay
        Future.delayed(const Duration(seconds: 2), () {
          if (mounted && !_roundOver) {
            setState(() {
              _currentDeckIndex++;
              _currentTargetCard = _deck[_currentDeckIndex];
              _showTargetSymbol = false; // Hide the next target card
              _feedbackMessage = ""; // Clear feedback for the next guess
              _isGuessingDisabled =
                  false; // Re-enable guessing for the next card
            });
          }
        });
      }
    });
  }

  // Helper method to build individual Zener symbol cards for user selection
  Widget _buildZenerSymbolCard(ZenerSymbol symbol) {
    return GestureDetector(
      onTap: () => _handleGuess(symbol),
      child: Card(
        elevation:
            _isGuessingDisabled ? 1.0 : 3.0, // Reduce elevation when disabled
        color: _isGuessingDisabled ? Colors.grey[300] : Colors.white,
        child: SizedBox(
          width: 60,
          height: 90,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  symbol.icon,
                  size: 30,
                  color: _isGuessingDisabled ? Colors.grey : Colors.deepPurple,
                ),
                const SizedBox(height: 4),
                Text(
                  symbol.displayName,
                  style: TextStyle(
                    fontSize: 10,
                    color: _isGuessingDisabled ? Colors.grey : Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey[100], // Removed to allow blur to be visible
      body: Stack(
        // Added Stack for background elements
        children: [
          // Rive Background Animation (Bottom Layer)
          const rive.RiveAnimation.asset(
            "assets/animations/breathing.riv", // Your new Rive animation
            fit: BoxFit.cover, // Ensure it covers the screen
          ),
          // Blur Effect (Middle Layer)
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 30,
                sigmaY: 30,
              ), // Same blur as onboarding
              child: const SizedBox(),
            ),
          ),
          // Original Screen Content (Top Layer)
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20.0,
                horizontal: 16.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  // Score and Position Counters
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Attempt: ${_roundOver ? _totalAttemptsInRound : _currentDeckIndex + 1}/$_totalAttemptsInRound',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color:
                              Colors
                                  .white, // Adjusted for better visibility on blurred background
                        ),
                      ),
                      Text(
                        'Correct: $_correctScore/$_totalAttemptsInRound',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color:
                              Colors
                                  .white, // Adjusted for better visibility on blurred background
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  const SizedBox(height: 10),

                  // Feedback Message Area
                  SizedBox(
                    height: 60, // Fixed height for feedback area
                    child: Center(
                      child: Text(
                        _feedbackMessage,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color:
                              _feedbackMessage.startsWith("Correct")
                                  ? Colors
                                      .green
                                      .shade300 // Adjusted for visibility
                                  : Colors
                                      .red
                                      .shade300, // Adjusted for visibility
                          shadows: const [
                            // Added shadow for better readability
                            Shadow(
                              blurRadius: 2.0,
                              color: Colors.black54,
                              offset: Offset(1.0, 1.0),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // "Play Again" Button or Spacer
                  if (_roundOver)
                    ElevatedButton.icon(
                      icon: const Icon(Icons.replay),
                      label: const Text('Play Again'),
                      onPressed: _startNewRound,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 15,
                        ),
                        textStyle: const TextStyle(fontSize: 16),
                      ),
                    )
                  else
                    const SizedBox(height: 50),
                  // Five selectable cards at the bottom
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children:
                          _selectableSymbols
                              .map((symbol) => _buildZenerSymbolCard(symbol))
                              .toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
