import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF6B4DFF), // deep purple top
              Color(0xFF8C6BFF), // softer mid
              Color(0xFFEAE5FF), // light fade
              Color(0xFFFFFFFF), // white bottom
            ],
            stops: [0.0, 0.35, 0.75, 1.0],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const Spacer(),
              // Title & subtitle
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: const [
                    Text(
                      'Navigate Your Work Journey\nEfficient & Easy',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF0D0F18),
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        height: 1.25,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Increase your work management & career\ndevelopment radically',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF7B8495),
                        fontSize: 13,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Buttons
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: FilledButton(
                        onPressed: () => Navigator.pushNamed(context, '/signin'),
                        style: FilledButton.styleFrom(
                          backgroundColor: const Color(0xFF6B4DFF),
                          shape: const StadiumBorder(),
                        ),
                        child: const Text(
                          'Sign In',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: OutlinedButton(
                        onPressed: () => Navigator.pushNamed(context, '/signup'),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFF6B4DFF), width: 1.5),
                          shape: const StadiumBorder(),
                          backgroundColor: Colors.transparent,
                        ),
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF6B4DFF),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
