import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:myapp/welcome_screen.dart'; // Update path as necessary
import 'firebase_options.dart'; // Ensure this file exists and is correctly configured

// Firebase initialization function
Future<void> initializeFirebase() async {
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    debugPrint('Error initializing Firebase: $e');
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Load environment variables
    await dotenv.load(fileName: "assets/.env");

    // Check if environment variables are loaded
    if (dotenv.env['FIREBASE_API_KEY'] == null) {
      throw Exception('Firebase API key is missing in .env file');
    }
  } catch (e) {
    debugPrint('Error loading .env file: $e');
  }

  await initializeFirebase();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Auth Screens',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Poppins',
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomeScreen(), 
      },
    );
  }
}
