import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import for SystemChrome
import 'package:psychic_trainer/screens/onboarding/onboarding_screen.dart';

void main() {
  // Ensure that plugin services are initialized so that `SystemChrome.setPreferredOrientations`
  // can be called before `runApp()`
  WidgetsFlutterBinding.ensureInitialized();

  // Then, set the preferred orientations to portrait only
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    // Once the orientation is set, run the app
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // The title of the application, used by the OS task switcher.
      title: 'Psychic Trainer',
      // The theme of the application.
      theme: ThemeData(
        // Define the default brightness and colors.
        brightness: Brightness.light,
        primarySwatch: Colors.deepPurple, // Using deepPurple as a base
        // Define the default font family.
        fontFamily: 'Poppins', // Assuming Poppins is set up in pubspec.yaml
        // Define the default TextTheme. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 57.0, fontWeight: FontWeight.bold),
          titleLarge: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
          bodyMedium: TextStyle(fontSize: 14.0),
          labelLarge: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
        ),
        // Define default button themes
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.deepPurple, // Text color
          ),
        ),
      ),
      // The widget to show when the app is started.
      home: const OnboardingScreen(),
      // Disable the debug banner in the top-right corner.
      debugShowCheckedModeBanner: false,
    );
  }
}
