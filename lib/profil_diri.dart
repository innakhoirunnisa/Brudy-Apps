// Ganti foto profil dengan menaruh gambar di assets/images/avatar.png
// (folder assets/images/ sudah terdaftar di pubspec.yaml)

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

const kNavy = Color(0xFF1F2A5C);
const kNavyDark = Color(0xFF232B66);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: const ProfilePage(),
    );
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _nameC = TextEditingController();
  final _usernameC = TextEditingController();
  final _emailC = TextEditingController();

  final List<String> _konsentrasi = ['Java', 'HTML', 'CSS'];

  final List<String> _gayaOptions = [
    '1-on-1',
    'Study Group',
    'Fokus Sunyi',
    'WFC',
  ];
  final Set<String> _gayaSelected = {'1-on-1'};

  @override
  void dispose() {
    _nameC.dispose();
    _usernameC.dispose();
    _emailC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: const Color(0xFFE5E7F1),
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 140),
          child: Column(
            children: [
              Text(
                'Profile',
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.w700,
                  color: kNavy,
                ),
              ),
              const SizedBox(height: 10),
              _buildAvatar(),
              const SizedBox(height: 14),
              _sectionTitle('Identitas Utama'),
              const SizedBox(height: 8),
              _field('Nama Lengkap', _nameC),
              _field('@username', _usernameC),
              _field(
                'Email Kampus',
                _emailC,
                keyboard: TextInputType.emailAddress,
              ),
              const SizedBox(height: 6),
              _sectionTitle('Academic & Learning'),
              const SizedBox(height: 8),
              _buildLearningCard(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const _BottomBar(),
    );
  }

  Widget _buildAvatar() {
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: kNavy, width: 4),
        color: Colors.grey.shade300,
      ),
      child: ClipOval(
        child: Image.asset(
          'assets/images/avatar.png',
          fit: BoxFit.cover,
          errorBuilder: (_, _, _) =>
              const Icon(Icons.person, size: 80, color: kNavy),
        ),
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Text(
      text,
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: kNavy),
    );
  }

  Widget _field(
    String label,
    TextEditingController c, {
    TextInputType? keyboard,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, bottom: 2),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: kNavy.withValues(alpha: 0.8),
              ),
            ),
          ),
          SizedBox(
            height: 38,
            child: TextField(
              controller: c,
              keyboardType: keyboard,
              style: TextStyle(fontSize: 14, color: kNavy),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: kNavy, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: kNavy, width: 1.6),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLearningCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: kNavy, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Konsentrasi Belajar',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: kNavy,
            ),
          ),
          const SizedBox(height: 8),
          _chipBox(
            _konsentrasi
                .map(
                  (t) => _chip(
                    t,
                    selected: true,
                    onTap: () => setState(() => _konsentrasi.remove(t)),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 14),
          Text(
            'Gaya Belajar',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: kNavy,
            ),
          ),
          const SizedBox(height: 8),
          _chipBox(
            _gayaOptions.map((t) {
              final sel = _gayaSelected.contains(t);
              return _chip(
                t,
                selected: sel,
                onTap: () => setState(() {
                  sel ? _gayaSelected.remove(t) : _gayaSelected.add(t);
                }),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _chipBox(List<Widget> children) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: kNavy, width: 1),
      ),
      child: Wrap(
        spacing: 4,
        runSpacing: 4,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: children,
      ),
    );
  }

  Widget _chip(
    String label, {
    required bool selected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: selected ? kNavy : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w700,
                color: selected ? Colors.white : kNavy,
              ),
            ),
            if (selected) ...[
              const SizedBox(width: 4),
              const Icon(Icons.close, size: 12, color: Colors.white),
            ],
          ],
        ),
      ),
    );
  }
}

class _BottomBar extends StatelessWidget {
  const _BottomBar();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: Stack(
        alignment: Alignment.bottomCenter,
        clipBehavior: Clip.none,
        children: [
          // Bar
          Container(
            height: 84,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xFF232B66), Color(0xFF3F4BB0)],
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 44),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {},
                  iconSize: 36,
                  color: Colors.white,
                  icon: const Icon(Icons.chat_bubble_outline_rounded),
                ),
                IconButton(
                  onPressed: () {},
                  iconSize: 38,
                  color: Colors.white,
                  icon: const Icon(Icons.account_circle_outlined),
                ),
              ],
            ),
          ),
          // Tombol tengah
          Positioned(
            top: 0,
            child: Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: kNavyDark,
                border: Border.all(color: const Color(0xFFA9B4F2), width: 5),
              ),
              child: IconButton(
                onPressed: () {},
                iconSize: 30,
                color: Colors.white,
                icon: const Icon(Icons.add_comment_outlined),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
