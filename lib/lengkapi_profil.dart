import 'package:flutter/material.dart';
import 'dashboard_chat.dart';

class LengkapiProfilPage extends StatefulWidget {
  const LengkapiProfilPage({super.key});

  @override
  State<LengkapiProfilPage> createState() => _LengkapiProfilPageState();
}

class _LengkapiProfilPageState extends State<LengkapiProfilPage> {
  final _emailKampusController = TextEditingController();
  final _kampusController = TextEditingController();
  final _prodiController = TextEditingController();

  int? _selectedSemester;
  final List<String> _selectedMataKuliah = [];

  final List<String> _daftarMataKuliah = [
    'Basis Data',
    'Sistem Operasi',
    'Pemrograman Website',
  ];

  @override
  void dispose() {
    _emailKampusController.dispose();
    _kampusController.dispose();
    _prodiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6E8F1),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1E2B50)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // ---------- Logo ----------
                  Center(
                    child: Image.asset(
                      'assets/images/logo_brudy.png',
                      width: 90,
                      height: 90,
                      errorBuilder: (_, __, ___) => const Icon(
                        Icons.school,
                        size: 80,
                        color: Color(0xFF1E2B50),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // ---------- Judul ----------
                  const Text(
                    'Lengkapi Profile',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF1E2B50),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // ---------- Email Kampus ----------
                  const _FieldLabel('Email Kampus'),
                  const SizedBox(height: 6),
                  _RoundedField(controller: _emailKampusController),
                  const SizedBox(height: 16),

                  // ---------- Kampus ----------
                  const _FieldLabel('Kampus'),
                  const SizedBox(height: 6),
                  _RoundedField(controller: _kampusController),
                  const SizedBox(height: 16),

                  // ---------- Program Studi ----------
                  const _FieldLabel('Program Studi'),
                  const SizedBox(height: 6),
                  _RoundedField(controller: _prodiController),
                  const SizedBox(height: 16),

                  // ---------- Semester (1-8) ----------
                  const _FieldLabel('Semester'),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 48,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: 8,
                      separatorBuilder: (_, __) => const SizedBox(width: 8),
                      itemBuilder: (context, index) {
                        int semester = index + 1;
                        bool isSelected = _selectedSemester == semester;
                        return GestureDetector(
                          onTap: () => setState(() => _selectedSemester = semester),
                          child: Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isSelected ? const Color(0xFF1E2B50) : Colors.white,
                              border: Border.all(
                                color: const Color(0xFF1E2B50),
                                width: 1.2,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                '$semester',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: isSelected ? Colors.white : const Color(0xFF1E2B50),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),

                  // ---------- Mata Kuliah ----------
                  const _FieldLabel('Mata Kuliah'),
                  const SizedBox(height: 8),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _daftarMataKuliah.length + 1,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 2.6,
                    ),
                    itemBuilder: (context, index) {
                      if (index < _daftarMataKuliah.length) {
                        String matkul = _daftarMataKuliah[index];
                        bool isSelected = _selectedMataKuliah.contains(matkul);
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              if (isSelected) {
                                _selectedMataKuliah.remove(matkul);
                              } else {
                                _selectedMataKuliah.add(matkul);
                              }
                            });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: isSelected ? const Color(0xFF1E2B50) : Colors.white,
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(
                                color: const Color(0xFF1E2B50),
                                width: 1.2,
                              ),
                            ),
                            child: Text(
                              matkul,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: isSelected ? Colors.white : const Color(0xFF1E2B50),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      } else {
                        return GestureDetector(
                          onTap: () {
                            // Berpindah ke halaman Dashboard Chat setelah profil lengkap diisi dan menghapus riwayat halaman sebelumnya
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => const DashboardChatPage()),
                              (route) => false,
                            );
                          },
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(
                                color: const Color(0xFF1E2B50),
                                width: 1.2,
                              ),
                            ),
                            child: const Text(
                              '+ Tambah',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1E2B50),
                              ),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 36),

                  // ---------- Tombol Mulai Cari Teman Belajar ----------
                  Container(
                    height: 60,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF202F55), Color(0xFF4565B8)],
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(30),
                        onTap: () {
                          // Aksi setelah profil lengkap selesai diisi
                        },
                        child: const Center(
                          child: Text(
                            'Mulai Cari Teman Belajar',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  final String text;
  const _FieldLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Text(text, style: const TextStyle(fontSize: 17, color: Color(0xFF4A5578))),
    );
  }
}

class _RoundedField extends StatelessWidget {
  final TextEditingController controller;
  const _RoundedField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(fontSize: 16, color: Color(0xFF1E2B50)),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: const BorderSide(color: Color(0xFF1E2B50), width: 1.2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: const BorderSide(color: Color(0xFF1E2B50), width: 2),
        ),
      ),
    );
  }
}