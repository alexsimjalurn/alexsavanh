import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final List<TextEditingController> _ctls =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _nodes = List.generate(6, (_) => FocusNode());

  @override
  void dispose() {
    for (final c in _ctls) c.dispose();
    for (final f in _nodes) f.dispose();
    super.dispose();
  }

  void _onChanged(int i, String v) {
    if (v.length > 1) {
      final digits = v.replaceAll(RegExp(r'[^0-9]'), '');
      for (int k = 0; k < 6; k++) {
        _ctls[k].text = k < digits.length ? digits[k] : '';
      }
      if (digits.length >= 6) _nodes[5].unfocus();
    } else if (v.isNotEmpty && i < 5) {
      _nodes[i + 1].requestFocus();
    } else if (v.isEmpty && i > 0) {
      _nodes[i - 1].requestFocus();
    }
    setState(() {});
  }

  bool get _ready => _ctls.every((c) => c.text.length == 1);

  @override
  Widget build(BuildContext context) {
    //const purple = Color(0xFF6B4DFF);
    final args = (ModalRoute.of(context)?.settings.arguments as Map?) ?? {};
    final method = (args['method'] as String?) ?? 'Email';
    final to = (args['to'] as String?) ?? '';

    return Scaffold(
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
                            child: const Icon(Icons.lock_outline,
                                color: Colors.white, size: 32),
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
                      Text(
                        'A reset code has been sent to $to, check your $method to continue the password reset process.',
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 13, height: 1.5, color: Color(0xFF7B8495)),
                      ),
                      const SizedBox(height: 20),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(6, (i) {
                          return SizedBox(
                            width: 48,
                            child: TextField(
                              controller: _ctls[i],
                              focusNode: _nodes[i],
                              maxLength: 1,
                              keyboardType: TextInputType.number,
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                              decoration: const InputDecoration(
                                counterText: '',
                                contentPadding: EdgeInsets.symmetric(vertical: 14),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(color: Color(0xFFDADCE3)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(color: Color(0xFF6B4DFF), width: 1.5),
                                ),
                              ),
                              onChanged: (v) => _onChanged(i, v),
                            ),
                          );
                        }),
                      ),

                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Haven't received the verification code? ",
                            style: TextStyle(color: Color(0xFF7B8495)),
                          ),
                          GestureDetector(
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Resent via $method')),
                              );
                            },
                            child: const Text(
                              'Resend it.',
                              style: TextStyle(
                                  color: Color(0xFF6B4DFF), fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),
                      SizedBox(
                        height: 56,
                        child: FilledButton(
                          onPressed: _ready
                              ? () => Navigator.pushNamed(context, '/reset',
                                  arguments: {'method': method, 'to': to})
                              : null,
                          child: const Text('Submit',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
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
}
