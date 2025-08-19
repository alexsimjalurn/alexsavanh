// =============================
// lib/screens/home_screen.dart
// =============================
import 'package:flutter/material.dart';
import '../data/local_auth.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _tab = 0;
  String _userName = 'User'; // Default name

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  Future<void> _loadUserName() async {
    final name = await LocalAuth.getStoredName();
    if (name != null && name.isNotEmpty && mounted) {
      setState(() {
        _userName = name;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    const purple = Color(0xFF6B4DFF);
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FB),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
            decoration: const BoxDecoration(
              color: Color(0xFF6B4DFF),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Back button
                GestureDetector(
                  onTap: () => Navigator.pushReplacementNamed(context, '/signin'),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                const CircleAvatar(radius: 22, backgroundColor: Colors.white,
                    child: Icon(Icons.person, color: Color(0xFF6B4DFF))),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(_userName,
                          style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w800)),
                      const SizedBox(height: 4),
                      const Text('ກະຊວງການເງິນ, ປະແສງ', style: TextStyle(color: Colors.white70)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.circular(16),
                    boxShadow: const [BoxShadow(color: Color(0x11000000), blurRadius: 8, offset: Offset(0, 4))],
                  ),
                  child: Column(children: [
                    Container(
                      height: 56,
                      decoration: BoxDecoration(color: const Color(0xFFE8E1FF), borderRadius: BorderRadius.circular(28)),
                      alignment: Alignment.center,
                      child: const Text('➡️  Swipe to Clock - IN',
                          style: TextStyle(color: Color(0xFF6B4DFF), fontWeight: FontWeight.w700)),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('Today, 08 July 2025'),
                        Row(children: [
                          Icon(Icons.schedule, size: 16, color: Color(0xFF6B4DFF)),
                          SizedBox(width: 6),
                          Text('09.00 - 17.00'),
                        ]),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(children: const [
                      Expanded(child: _MiniCard('CLOCK IN')),
                      SizedBox(width: 12),
                      Expanded(child: _MiniCard('CLOCK OUT')),
                    ]),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const [
                        _Stat('27', 'Your Absence'), _DividerV(),
                        _Stat('01', 'Late Clock In'), _DividerV(),
                        _Stat('03', 'No Clock In'),
                      ],
                    ),
                  ]),
                ),
                const SizedBox(height: 16),
                _categoryGrid(),
              ]),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _tab,
        selectedItemColor: purple,
        onTap: (i) => setState(() => _tab = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

class _MiniCard extends StatelessWidget {
  final String label;
  const _MiniCard(this.label);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      decoration: BoxDecoration(color: const Color(0xFFE8E1FF), borderRadius: BorderRadius.circular(12)),
      child: Center(child: Text(label, style: const TextStyle(color: Color(0xFF0D0F18), fontWeight: FontWeight.w700))),
    );
  }
}

class _Stat extends StatelessWidget {
  final String num;
  final String label;
  const _Stat(this.num, this.label);
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(num, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
      const SizedBox(height: 4),
      Text(label, style: const TextStyle(color: Colors.black54)),
    ]);
  }
}

class _DividerV extends StatelessWidget {
  const _DividerV();
  @override
  Widget build(BuildContext context) => Container(width: 1, height: 28, color: const Color(0xFFE6E7EB));
}

Widget _categoryGrid() {
  final items = const [
    Icons.access_time, Icons.calendar_month, Icons.event_available,
    Icons.view_list, Icons.people, Icons.description,
  ];
  final names = const [
    'Clock In-Out\nHistory', 'Absents\nHistory', 'Leave\nRequest',
    'Task\nManagement', 'Meeting', 'Documents',
  ];
  return GridView.builder(
    shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), itemCount: items.length,
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3, mainAxisSpacing: 12, crossAxisSpacing: 12, childAspectRatio: 1,
    ),
    itemBuilder: (context, i) => Container(
      decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: Color(0x11000000), blurRadius: 6, offset: Offset(0, 3))],
      ),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          width: 44, height: 44,
          decoration: BoxDecoration(color: const Color(0xFFE8E1FF), borderRadius: BorderRadius.circular(12)),
          child: Icon(items[i], color: const Color(0xFF6B4DFF)),
        ),
        const SizedBox(height: 8),
        Text(names[i], textAlign: TextAlign.center, style: const TextStyle(fontSize: 12, color: Color(0xFF0D0F18))),
      ]),
    ),
  );
}
