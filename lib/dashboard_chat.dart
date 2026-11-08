import 'package:brudy/chatroom_page.dart';
import 'package:flutter/material.dart';

class DashboardChatPage extends StatefulWidget {
  const DashboardChatPage({super.key});

  @override
  State<DashboardChatPage> createState() => _DashboardChatPageState();
}

class _DashboardChatPageState extends State<DashboardChatPage> {
  var _chatList = [
    {
      'name': 'Valeria',
      'message': 'abcdefghijklmnopqrstuvwxyz',
      'time': 'Hari Ini\n08.24',
      'image': 'assets/images/valeria.png', // Sesuaikan asset gambar jika ada
    },
    {
      'name': 'Qin Che',
      'message': 'abcdefghijklmnopqrstuvwxyz',
      'time': 'Kemarin\n23.59',
      'image': 'assets/images/qinche.png',
    },
    {
      'name': 'Ao Yin',
      'message': 'abcdefghijklmnopqrstuvwxyz',
      'time': 'Kemarin\n17.30',
      'image': 'assets/images/aoyin.png',
    },
  ];

  int _currentIndex = 0; // 0 untuk menu chat, 1 untuk profil/menu lain

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6E8F1), // Latar belakang abu-kebiruan senada
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),
            // ---------- Header Judul BRUDY ----------
            const Text(
              'BRUDY',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w900,
                color: Color(0xFF1E2B50),
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 16),

            // ---------- Kotak Pencarian (Search Bar) ----------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: const Color(0xFF1E2B50),
                    width: 1.2,
                  ),
                ),
                child: const TextField(
                  style: TextStyle(color: Color(0xFF1E2B50)),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search, color: Color(0xFF1E2B50)),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Divider(color: Color(0xFFB0BACB), thickness: 1, indent: 24, endIndent: 24),
            const SizedBox(height: 8),

            // ---------- Daftar Chat (ListView) ----------
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                itemCount: _chatList.length,
                itemBuilder: (context, index) {
                  final chat = _chatList[index];

                  return GestureDetector(
                    onTap: () {
                      // Aksi ketika chat diklik, misalnya membuka halaman chat detail
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatRoomPage(
                            peerName: chat['name']!,
                            peerImage: chat['image']!,
                            isOnline: true, // Atur status online sesuai kebutuhan
                          ),
                        )
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: const Color(0xFF1E2B50),
                          width: 1.2,
                        ),
                      ),
                      child: Row(
                        children: [
                          // Foto Profil Bulat dengan Border Biru
                          Container(
                            width: 56,
                            height: 56,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: const Color(0xFF1E2B50),
                                width: 2,
                              ),
                            ),
                            child: ClipOval(
                              child: Image.asset(
                                chat['image']!,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) => const Icon(
                                  Icons.person,
                                  size: 32,
                                  color: Color(0xFF1E2B50),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          
                          // Nama dan Pesan
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  chat['name']!,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF1E2B50),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  chat['message']!,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: Color(0xFF4A5578),
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),

                          // Waktu Pesan
                          Text(
                            chat['time']!,
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                              fontSize: 11,
                              color: Color(0xFF4A5578),
                              height: 1.2,
                            ),
                          ),
                        ],
                      ),
                    )
                  );
                },
              ),
            ),
          ],
        ),
      ),

      // ---------- Bottom Navigation Bar Khas Brudy ----------
      bottomNavigationBar: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          Container(
            height: 70,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF202F55), Color(0xFF4565B8)],
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.chat_bubble_outline,
                    color: _currentIndex == 0 ? Colors.white : Colors.white60,
                    size: 28,
                  ),
                  onPressed: () => setState(() => _currentIndex = 0),
                ),
                const SizedBox(width: 40), // Ruang kosong untuk tombol plus melayang
                IconButton(
                  icon: Icon(
                    Icons.person_outline,
                    color: _currentIndex == 1 ? Colors.white : Colors.white60,
                    size: 28,
                  ),
                  onPressed: () => setState(() => _currentIndex = 1),
                ),
              ],
            ),
          ),
          // Tombol Lingkaran Plus di Tengah Navigasi Bawah
          Positioned(
            top: -22,
            child: Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [Color(0xFF202F55), Color(0xFF4565B8)],
                ),
                border: Border.all(color: Colors.white, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: IconButton(
                icon: const Icon(Icons.add, color: Colors.white, size: 28),
                onPressed: () {
                  // Aksi untuk menambah teman / chat baru
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}