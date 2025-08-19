import 'package:flutter/material.dart';
import '../data/local_auth.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();
  bool _ob1 = true;
  bool _ob2 = true;
  bool _accept = true;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _passCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const purple = Color(0xFF6B4DFF);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
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
                      const SizedBox(height: 6),
                      const Text('Sign Up', textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800, color: Color(0xFF0D0F18))),
                      const SizedBox(height: 6),
                      const Text('Create your account', textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 13, height: 1.5, color: Color(0xFF7B8495))),
                      const SizedBox(height: 24),

                      const Text('Full Name', style: TextStyle(fontSize: 13, color: Color(0xFF0D0F18))),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _nameCtrl,
                        textCapitalization: TextCapitalization.words,
                        decoration: _dec(purple, hint: 'Your Name', prefix: const Icon(Icons.person_outline)),
                        validator: (v) => (v == null || v.trim().isEmpty) ? 'Please enter your name' : null,
                      ),

                      const SizedBox(height: 16),
                      const Text('Email', style: TextStyle(fontSize: 13, color: Color(0xFF0D0F18))),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _emailCtrl,
                        keyboardType: TextInputType.emailAddress,
                        decoration: _dec(purple, hint: 'you@example.com', prefix: const Icon(Icons.mail_outline)),
                        validator: (v) {
                          if (v == null || v.trim().isEmpty) return 'Please enter email';
                          if (!v.contains('@') || !v.contains('.')) return 'Invalid email';
                          return null;
                        },
                      ),

                      const SizedBox(height: 16),
                      const Text('Phone Number', style: TextStyle(fontSize: 13, color: Color(0xFF0D0F18))),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _phoneCtrl,
                        keyboardType: TextInputType.phone,
                        decoration: _dec(purple, hint: '+856 xx xxxx xxxx', prefix: const Icon(Icons.phone_outlined)),
                        validator: (v) {
                          if (v == null || v.trim().isEmpty) return 'Please enter phone number';
                          if (v.length < 10) return 'Phone number should be at least 10 digits';
                          return null;
                        },
                      ),

                      const SizedBox(height: 16),
                      const Text('Password', style: TextStyle(fontSize: 13, color: Color(0xFF0D0F18))),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _passCtrl,
                        obscureText: _ob1,
                        decoration: _dec(purple, hint: 'Create a password', prefix: const Icon(Icons.key_outlined))
                            .copyWith(
                          suffixIcon: IconButton(
                            icon: Icon(_ob1 ? Icons.visibility_off_outlined : Icons.visibility_outlined),
                            onPressed: () => setState(() => _ob1 = !_ob1),
                          ),
                        ),
                        validator: (v) {
                          if (v == null || v.isEmpty) return 'Please enter password';
                          if (v.length < 6) return 'At least 6 characters';
                          return null;
                        },
                      ),

                      const SizedBox(height: 16),
                      const Text('Confirm Password', style: TextStyle(fontSize: 13, color: Color(0xFF0D0F18))),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _confirmCtrl,
                        obscureText: _ob2,
                        decoration: _dec(purple, hint: 'Re-enter your password', prefix: const Icon(Icons.key_outlined))
                            .copyWith(
                          suffixIcon: IconButton(
                            icon: Icon(_ob2 ? Icons.visibility_off_outlined : Icons.visibility_outlined),
                            onPressed: () => setState(() => _ob2 = !_ob2),
                          ),
                        ),
                        validator: (v) {
                          if (v == null || v.isEmpty) return 'Please confirm password';
                          if (v != _passCtrl.text) return 'Passwords do not match';
                          return null;
                        },
                      ),

                      const SizedBox(height: 12),
                      Row(children: [
                        Checkbox(
                          value: _accept,
                          activeColor: purple,
                          onChanged: (v) => setState(() => _accept = v ?? false),
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        const Expanded(
                          child: Text('I agree to the Terms & Privacy Policy', style: TextStyle(color: Color(0xFF7B8495))),
                        ),
                      ]),

                      const SizedBox(height: 8),
                      SizedBox(
                        height: 56,
                        child: FilledButton(
                          onPressed: _accept ? _submit : null,
                          style: FilledButton.styleFrom(backgroundColor: purple, shape: const StadiumBorder()),
                          child: const Text('Create Account', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                        ),
                      ),

                      const SizedBox(height: 16),
                      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                        const Text('Already have an account? ', style: TextStyle(color: Color(0xFF7B8495))),
                        GestureDetector(
                          onTap: () => Navigator.pushReplacementNamed(context, '/signin'),
                          child: const Text('Sign In',
                              style: TextStyle(color: Color(0xFF6B4DFF), fontWeight: FontWeight.w600)),
                        ),
                      ]),
                    ]),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration _dec(Color purple, {required String hint, required Widget prefix}) {
    const r = BorderRadius.all(Radius.circular(12));
    return InputDecoration(
      hintText: hint,
      prefixIcon: prefix,
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      enabledBorder: const OutlineInputBorder(borderRadius: r, borderSide: BorderSide(color: Color(0xFFDADCE3))),
      focusedBorder: OutlineInputBorder(borderRadius: r, borderSide: BorderSide(color: purple, width: 1.5)),
      errorBorder: const OutlineInputBorder(borderRadius: r, borderSide: BorderSide(color: Colors.redAccent)),
    );
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    await LocalAuth.saveCredentials(
      _emailCtrl.text.trim(), 
      _passCtrl.text,
      phone: _phoneCtrl.text.trim(),
      name: _nameCtrl.text.trim(),
    );
    if (!mounted) return;
    // สมัครเสร็จ → กลับหน้า Sign In เพื่อให้ล็อกอินด้วยบัญชีที่เพิ่งสร้าง
    Navigator.pushNamedAndRemoveUntil(context, '/signin', (r) => false);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Account created with phone recovery option. Please sign in.')),
    );
  }
}
