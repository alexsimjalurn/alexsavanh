import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';
import 'screens/sign_in_screen.dart';
import 'screens/forgot_password_screen.dart';
import 'screens/otp_screen.dart';
import 'screens/reset_password_screen.dart';
import 'screens/password_created_screen.dart';
import 'screens/home_screen.dart';
import 'screens/sign_up_screen.dart';




void main() => runApp(const MyApp());


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Work Journey',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF6B4DFF)),
        textTheme: const TextTheme(
          headlineMedium: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w800,
            color: Color(0xFF0D0F18),
            height: 1.25,
          ),
          bodyMedium: TextStyle(
            fontSize: 13,
            height: 1.5,
            color: Color(0xFF7B8495),
          ),
        ),
      ),
      home: const WelcomeScreen(),
      routes: {
              '/signin': (_) => const SignInScreen(),
              '/signup': (_) => const SignUpScreen(),
              '/forgot': (_) => const ForgotPasswordScreen(),
              '/otp': (_) => const OtpScreen(),
              '/reset': (_) => const ResetPasswordScreen(),
              '/password-created': (_) => const PasswordCreatedScreen(),
              '/home': (_) => const HomeScreen(),
            },

    );
  }
}

// class _PlaceholderPage extends StatelessWidget {
//   final String title;
//   const _PlaceholderPage({required this.title});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(title)),
//       body: Center(
//         child: Text('$title page here'),
//       ),
//     );
//   }
// }