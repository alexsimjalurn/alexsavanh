import 'package:flutter/material.dart';
import '../data/local_auth.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _p1 = TextEditingController();
  final _p2 = TextEditingController();
  bool _ob1 = true;
  bool _ob2 = true;
  late final String _identifier; // email/phone จากหน้า OTP
  late final String _method; // method used (Email, SMS, WhatsApp)

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = (ModalRoute.of(context)?.settings.arguments as Map?) ?? {};
    _identifier = (args['to'] as String?) ?? '';
    _method = (args['method'] as String?) ?? 'Email';
  }

  @override
  void dispose() {
    _p1.dispose();
    _p2.dispose();
    super.dispose();
  }

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
              borderRadius: BorderRadius.only(topLeft: Radius.circular(28), topRight: Radius.circular(28)),
            ),
            child: SafeArea(
              top: false,
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
                child: Form(
                  key: _formKey,
                  child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
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
                            boxShadow: const [BoxShadow(color: Color(0x406B4DFF), blurRadius: 20, offset: Offset(0, 12))],
                          ),
                          child: const Icon(Icons.lock_reset, color: Colors.white, size: 32),
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text('Set a New Password',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: Color(0xFF0D0F18))),
                    const SizedBox(height: 8),
                    const Text('Please set a new password to secure your Work Mate account.',
                        textAlign: TextAlign.center, style: TextStyle(fontSize: 13, height: 1.5, color: Color(0xFF7B8495))),
                    const SizedBox(height: 20),

                    const Text('Password', style: TextStyle(fontSize: 13, color: Color(0xFF0D0F18))),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _p1,
                      obscureText: _ob1,
                      decoration: InputDecoration(
                        hintText: 'Input Password',
                        prefixIcon: const Icon(Icons.fingerprint, color: purple),
                        suffixIcon: IconButton(
                          icon: Icon(_ob1 ? Icons.visibility_off_outlined : Icons.visibility_outlined),
                          onPressed: () => setState(() => _ob1 = !_ob1),
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          borderSide: BorderSide(color: Color(0xFFDADCE3)),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          borderSide: BorderSide(color: purple, width: 1.5),
                        ),
                      ),
                      validator: (v) {
                        if (v == null || v.isEmpty) return 'Enter password';
                        if (v.length < 6) return 'At least 6 characters';
                        return null;
                      },
                    ),

                    const SizedBox(height: 16),
                    const Text('Confirm Password', style: TextStyle(fontSize: 13, color: Color(0xFF0D0F18))),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _p2,
                      obscureText: _ob2,
                      decoration: InputDecoration(
                        hintText: 'Re Enter Your Password',
                        prefixIcon: const Icon(Icons.fingerprint, color: purple),
                        suffixIcon: IconButton(
                          icon: Icon(_ob2 ? Icons.visibility_off_outlined : Icons.visibility_outlined),
                          onPressed: () => setState(() => _ob2 = !_ob2),
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          borderSide: BorderSide(color: Color(0xFFDADCE3)),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          borderSide: BorderSide(color: purple, width: 1.5),
                        ),
                      ),
                      validator: (v) {
                        if (v == null || v.isEmpty) return 'Confirm password';
                        if (v != _p1.text) return 'Passwords do not match';
                        return null;
                      },
                    ),

                    const SizedBox(height: 20),
                    SizedBox(
                      height: 56,
                      child: FilledButton(
                        onPressed: () async {
                          if (_formKey.currentState?.validate() ?? false) {
                            bool success = false;
                            
                            // If method is SMS or WhatsApp (phone-based), use phone reset
                            if (_method == 'SMS' || _method == 'WhatsApp') {
                              success = await LocalAuth.resetPasswordWithPhone(_identifier, _p1.text);
                            } else {
                              // For email-based reset, use the old method
                              await LocalAuth.saveCredentials(
                                _identifier.isNotEmpty ? _identifier : 'example@gmail.com',
                                _p1.text,
                              );
                              success = true;
                            }
                            
                            if (!mounted) return;
                            
                            if (success) {
                              Navigator.pushNamedAndRemoveUntil(context, '/password-created', (r) => false);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Failed to reset password. Please try again.'),
                                  backgroundColor: Colors.redAccent,
                                ),
                              );
                            }
                          }
                        },
                        style: FilledButton.styleFrom(backgroundColor: purple, shape: const StadiumBorder()),
                        child: const Text('Submit', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                 ),
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

}