import 'package:flutter/material.dart';
import '../data/local_auth.dart';



class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  bool _remember = false;
  bool _obscure = true;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final purple = const Color(0xFF6B4DFF);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          // Background gradient (dark)
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF2A2080), Color(0xFF171B3A)],
              ),
            ),
            child: SizedBox.expand(),
          ),

          // Bottom sheet style card
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              constraints: const BoxConstraints(maxWidth: 480),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(28),
                  topRight: Radius.circular(28),
                ),
              ),
              child: SafeArea(
                top: false,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 6),
                        const Text(
                          'Sign In',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF0D0F18),
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          'Sign in to my account',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 13,
                            height: 1.5,
                            color: Color(0xFF7B8495),
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Email
                        const Text('Email', style: TextStyle(fontSize: 13, color: Color(0xFF0D0F18))),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _emailCtrl,
                          keyboardType: TextInputType.emailAddress,
                          decoration: _inputDecoration(
                            hint: 'My Email',
                            prefix: const Icon(Icons.mail_outline),
                            purple: purple,
                          ),
                          validator: (v) {
                            if (v == null || v.trim().isEmpty) return 'Please enter email';
                            if (!v.contains('@') || !v.contains('.')) return 'Invalid email';
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),

                        // Password
                        const Text('Password', style: TextStyle(fontSize: 13, color: Color(0xFF0D0F18))),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _passwordCtrl,
                          obscureText: _obscure,
                          decoration: _inputDecoration(
                            hint: 'My Password',
                            prefix: const Icon(Icons.key_outlined),
                            purple: purple,
                          ).copyWith(
                            suffixIcon: IconButton(
                              icon: Icon(_obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined),
                              onPressed: () => setState(() => _obscure = !_obscure),
                            ),
                          ),
                          validator: (v) {
                            if (v == null || v.isEmpty) return 'Please enter password';
                            if (v.length < 6) return 'At least 6 characters';
                            return null;
                          },
                        ),

                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Checkbox(
                              value: _remember,
                              activeColor: purple,
                              onChanged: (val) => setState(() => _remember = val ?? false),
                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            const Text('Remember Me'),
                            const Spacer(),
                            TextButton(
                              onPressed: () => Navigator.pushNamed(context, '/forgot'),
                              child: const Text('Forgot Password', style: TextStyle(color: Color(0xFF6B4DFF))),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),

                        // Primary button
                        SizedBox(
                          height: 56,
                          child: FilledButton(
                            onPressed: _submit,
                            style: FilledButton.styleFrom(
                              backgroundColor: purple,
                              shape: const StadiumBorder(),
                            ),
                            child: const Text('Sign In', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Divider with OR
                        Row(
                          children: const [
                            Expanded(child: Divider(thickness: 1, color: Color(0xFFE6E7EB))),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              child: Text('OR', style: TextStyle(color: Color(0xFF9AA2B1))),
                            ),
                            Expanded(child: Divider(thickness: 1, color: Color(0xFFE6E7EB))),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Outline phone button
                        SizedBox(
                          height: 56,
                          child: OutlinedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.phone_iphone),
                            label: const Text('Sign in With Phone Number',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: purple, width: 1.5),
                              shape: const StadiumBorder(),
                              foregroundColor: purple,
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),
                        // Footer
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don't have an account? ", style: TextStyle(color: Color(0xFF7B8495))),
                            GestureDetector(
                              onTap: () => Navigator.pushNamed(context, '/signup'),
                              child: const Text('Sign Up Here', style: TextStyle(color: Color(0xFF6B4DFF), fontWeight: FontWeight.w600)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration({required String hint, required Widget prefix, required Color purple, Widget? suffix}) {
    const borderRadius = BorderRadius.all(Radius.circular(12));
    const borderSide = BorderSide(color: Color(0xFFDADCE3));
    return InputDecoration(
      hintText: hint,
      prefixIcon: prefix,
      suffixIcon: suffix,
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      enabledBorder: const OutlineInputBorder(borderRadius: borderRadius, borderSide: borderSide),
      focusedBorder: OutlineInputBorder(borderRadius: borderRadius, borderSide: BorderSide(color: purple, width: 1.5)),
      errorBorder: const OutlineInputBorder(borderRadius: borderRadius, borderSide: BorderSide(color: Colors.redAccent)),
    );
  }

  void _submit() async {
  if (_formKey.currentState?.validate() ?? false) {
    final ok = await LocalAuth.signIn(
      _emailCtrl.text.trim(),
      _passwordCtrl.text,
    );
    if (!mounted) return;
    if (ok) {
      if (_remember) await LocalAuth.setLoggedIn(true);
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid email or password')),
      );
    }
  }
}


}
