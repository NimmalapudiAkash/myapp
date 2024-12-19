// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, avoid_print

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myapp/home.dart';

import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  // Function to handle registration
  Future<void> _registerUser() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    // Validate that fields are not empty before other checks
    if (email.isEmpty) {
      _showError('Email field cannot be empty');
      return;
    }

    if (password.isEmpty) {
      _showError('Password field cannot be empty');
      return;
    }

    if (confirmPassword.isEmpty) {
      _showError('Confirm Password field cannot be empty');
      return;
    }

    // Improved email validation using regex
    const emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    final isValidEmail = RegExp(emailPattern).hasMatch(email);

    if (!isValidEmail) {
      _showError('Please enter a valid email address');
      return;
    }

    if (password != confirmPassword) {
      _showError('Passwords do not match');
      return;
    }

    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Registration successful, navigate to login screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const EnhancedHomePage()),
      );
    } on FirebaseAuthException catch (e) {
      _showError(e.message ?? 'Registration failed');
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Hello! Register to get\nstarted',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 32),
                TextFieldWidget(
                  hintText: 'Email',
                  controller: _emailController,
                ),
                const SizedBox(height: 16),
                TextFieldWidget(
                  hintText: 'Password',
                  isPassword: true,
                  controller: _passwordController,
                ),
                const SizedBox(height: 16),
                TextFieldWidget(
                  hintText: 'Confirm password',
                  isPassword: true,
                  controller: _confirmPasswordController,
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _registerUser,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black87,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Register',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                const Center(child: Text('Or Register with')),
                const SizedBox(height: 24),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SocialLoginButton(imagePath: 'assets/images/face.png'),
                    SocialLoginButton(imagePath: 'assets/images/google.png'),
                    SocialLoginButton(imagePath: 'assets/images/apple.png'),
                  ],
                ),
                const SizedBox(height: 24),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already have an account?'),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                          );
                        },
                        child: const Text('Login Now'),
                      ),
                    ],
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
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}

// text_field_widget.dart

class TextFieldWidget extends StatelessWidget {
  final String hintText;
  final bool isPassword;
  final TextEditingController controller;

  const TextFieldWidget({
    super.key,
    required this.hintText,
    this.isPassword = false,
    required this.controller, // Assign the controller here
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller, // Set the controller to the TextField
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        suffixIcon: isPassword ? const Icon(Icons.visibility_off) : null,
      ),
    );
  }
}

// social_login_button.dart

class SocialLoginButton extends StatelessWidget {
  final String imagePath;

  const SocialLoginButton({
    super.key,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Handle social login
      },
      child: Image.asset(
        imagePath,
        width: 50,
        height: 50,
      ),
    );
  }
}
