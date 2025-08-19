import 'package:flutter/material.dart';
import '../data/local_auth.dart';

enum _Method { whatsapp, sms, email }

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _contactCtrl = TextEditingController();
  _Method _selected = _Method.whatsapp;

  @override
  void dispose() {
    _contactCtrl.dispose();
    super.dispose();
  }

  bool get _isEmail => _selected == _Method.email;

  bool _isValid() {
    final txt = _contactCtrl.text.trim();
    if (_isEmail) {
      return txt.contains('@') && txt.contains('.');
    } else {
      final digits = txt.replaceAll(RegExp('[^0-9]'), '');
      return digits.length >= 6; // very light validation
    }
  }

  String get _buttonText {
    switch (_selected) {
      case _Method.whatsapp:
        return 'Send Verification Code Via WhatsApp';
      case _Method.sms:
        return 'Send Verification Code Via SMS';
      case _Method.email:
        return 'Send Verification Code Via Email';
    }
  }

  @override
  Widget build(BuildContext context) {
    const purple = Color(0xFF6B4DFF);

    return Scaffold(
      body: Stack(
        children: [
          // Dark background gradient
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

          // Sheet
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              constraints: const BoxConstraints(maxWidth: 480),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Floating icon
                      Center(
                        child: Transform.translate(
                          offset: const Offset(0, -28),
                          child: Container(
                            width: 72,
                            height: 72,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              gradient: const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Color(0xFF7C5CFF), Color(0xFF6B4DFF)],
                              ),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x406B4DFF),
                                  blurRadius: 20,
                                  offset: Offset(0, 12),
                                )
                              ],
                            ),
                            child: const Icon(Icons.lock_outline, color: Colors.white, size: 32),
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Forgot Password',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF0D0F18),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Choose your preferred method to receive a verification code and reset your password.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 13, height: 1.5, color: Color(0xFF7B8495)),
                      ),
                      const SizedBox(height: 20),

                      // Method buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: _MethodButton(
                              label: 'WhatsApp',
                              icon: Icons.chat_bubble_outline,
                              selected: _selected == _Method.whatsapp,
                              onTap: () => setState(() => _selected = _Method.whatsapp),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _MethodButton(
                              label: 'SMS',
                              icon: Icons.sms_outlined,
                              selected: _selected == _Method.sms,
                              onTap: () => setState(() => _selected = _Method.sms),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _MethodButton(
                              label: 'Email',
                              icon: Icons.mail_outline,
                              selected: _selected == _Method.email,
                              onTap: () => setState(() => _selected = _Method.email),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // Input field (phone or email)
                      Text(_isEmail ? 'Email' : 'Phone number',
                          style: const TextStyle(fontSize: 13, color: Color(0xFF0D0F18))),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _contactCtrl,
                        keyboardType:
                            _isEmail ? TextInputType.emailAddress : TextInputType.phone,
                        onChanged: (_) => setState(() {}),
                        decoration: InputDecoration(
                          hintText: _isEmail ? 'Email' : 'Phone number',
                          prefixIcon:
                              Icon(_isEmail ? Icons.mail_outline : Icons.phone_iphone, color: purple),
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
                      ),

                      const SizedBox(height: 20),

                      // Send button
                      SizedBox(
                        height: 56,
                        child: FilledButton(
                          onPressed: _isValid() ? _send : null,
                          style: FilledButton.styleFrom(
                            backgroundColor: purple,
                            shape: const StadiumBorder(),
                          ),
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              _buttonText,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _send() async {
    FocusScope.of(context).unfocus();
    final contact = _contactCtrl.text.trim();
    
    // For phone-based methods (WhatsApp and SMS), validate against stored phone
    if (_selected == _Method.whatsapp || _selected == _Method.sms) {
      final storedPhone = await LocalAuth.getStoredPhone();
      if (storedPhone == null || storedPhone != contact) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Phone number not found. Please use the phone number you registered with.'),
            backgroundColor: Colors.redAccent,
          ),
        );
        return;
      }
    }
    
    final method = _selected == _Method.whatsapp
        ? 'WhatsApp'
        : _selected == _Method.sms
            ? 'SMS'
            : 'Email';
    
    if (!mounted) return;
    Navigator.pushNamed(
      context,
      '/otp',
      arguments: {'method': method, 'to': contact},
    );
  }
}

class _MethodButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;
  const _MethodButton({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const purple = Color(0xFF6B4DFF);
    final fg = selected ? Colors.white : const Color(0xFF0D0F18);
    return OutlinedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, color: selected ? Colors.white : purple),
      label: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontWeight: FontWeight.w600, color: fg),
        ),
      ),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
        shape: const StadiumBorder(),
        side: BorderSide(color: selected ? Colors.transparent : const Color(0xFFDADCE3), width: 1.5),
        backgroundColor: selected ? purple : Colors.white,
        foregroundColor: fg,
      ),
    );
  }
}