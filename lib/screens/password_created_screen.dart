// =============================
// lib/screens/password_created_screen.dart
// =============================
import 'package:flutter/material.dart';

class PasswordCreatedScreen extends StatelessWidget {
  const PasswordCreatedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const purple = Color(0xFF6B4DFF);
    return Scaffold(
      body: Stack(children: [
        const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter, end: Alignment.bottomCenter,
              colors: [Color(0xFF2A2080), Color(0xFF171B3A)],
            ),
          ),
          child: SizedBox.expand(),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            constraints: const BoxConstraints(maxWidth: 480),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(28), topRight: Radius.circular(28),
              ),
            ),
            child: SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: Transform.translate(
                        offset: const Offset(0, -28),
                        child: Container(
                          width: 72, height: 72,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            gradient: const LinearGradient(
                              begin: Alignment.topCenter, end: Alignment.bottomCenter,
                              colors: [Color(0xFF7C5CFF), Color(0xFF6B4DFF)],
                            ),
                            boxShadow: const [
                              BoxShadow(color: Color(0x406B4DFF), blurRadius: 20, offset: Offset(0, 12)),
                            ],
                          ),
                          child: const Icon(Icons.lock_outline, color: Colors.white, size: 32),
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text('Password Has Been Created',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: Color(0xFF0D0F18))),
                    const SizedBox(height: 8),
                    const Text(
                      'To log in to your account, click the Sign in button and enter your email along with your new password.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 13, height: 1.5, color: Color(0xFF7B8495)),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 56,
                      child: FilledButton(
                        onPressed: () => Navigator.pushNamedAndRemoveUntil(context, '/signin', (r) => false),
                        style: FilledButton.styleFrom(backgroundColor: purple, shape: const StadiumBorder()),
                        child: const Text('Sign In', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
