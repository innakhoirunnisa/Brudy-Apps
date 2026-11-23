import 'package:flutter/material.dart';

class ChatRoomPage extends StatefulWidget {
  final String peerName;
  final String peerImage;
  final bool isOnline; // Status untuk menentukan Online atau Offline

  const ChatRoomPage({
    super.key,
    required this.peerName,
    required this.peerImage,
    this.isOnline = true, // Default online
  });

  @override
  State<ChatRoomPage> createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  final TextEditingController _messageController = TextEditingController();

  // Contoh data pesan di dalam ruangan chat
  var _messages = [
    {
      'sender': 'peer',
      'message': 'Halo!',
      'time': '08.25',
    },
    {
      'sender': 'me',
      'message': 'Halooo',
      'time': '08.26',
    },
    {
      'sender': 'peer',
      'message': 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',
      'time': '08.28',
    },
    {
      'sender': 'me',
      'message': 'Iyaaa',
      'time': '08.30',
    },
  ];

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;
    setState(() {
      _messages.add({
        'sender': 'me',
        'message': _messageController.text,
        'time': 'Baru saja',
      });
    });
    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6E8F1), // Warna latar belakang abu-kebiruan khas Brudy
      body: SafeArea(
        child: Column(
          children: [
            // ---------- HEADER / APP BAR CUSTOM ----------
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF202F55), Color(0xFF4565B8)],
                ),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  // Tombol Kembali
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
                    onPressed: () => Navigator.pop(context),
                  ),
                  // Foto Profil
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 1.5),
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        widget.peerImage,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const Icon(Icons.person, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Nama dan Status (Bisa Berubah Otomatis Sesuai Parameter)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.peerName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                // Titik hijau jika online, abu-abu jika offline
                                color: widget.isOnline ? Colors.greenAccent : Colors.grey,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              widget.isOnline ? 'Online' : 'Offline',
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // ---------- KONTEN PESAN (CHAT BUBBLE) ----------
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  const SizedBox(height: 8),
                  // Indikator Waktu "Hari Ini"
                  Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFF202F55),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        'Hari Ini',
                        style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Daftar Pesan
                  ..._messages.map((chat) {
                    bool isMe = chat['sender'] == 'me';
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Row(
                        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          // Foto Profil di Kiri (Jika pesan dari Teman)
                          if (!isMe) ...[
                            Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: const Color(0xFF1E2B50), width: 1.5),
                              ),
                              child: ClipOval(
                                child: Image.asset(
                                  widget.peerImage,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => const Icon(Icons.person, size: 20),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                          ],

                          // Gelembung Pesan (Chat Bubble)
                          Flexible(
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: isMe
                                      ? [const Color(0xFF3B5998), const Color(0xFF4565B8)]
                                      : [const Color(0xFF202F55), const Color(0xFF4565B8)],
                                ),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: const Color(0xFF1E2B50), width: 1),
                              ),
                              child: Text(
                                chat['message']!,
                                style: const TextStyle(color: Colors.white, fontSize: 14),
                              ),
                            ),
                          ),

                          // Foto Profil di Kanan (Jika pesan dari Saya)
                          if (isMe) ...[
                            const SizedBox(width: 8),
                            Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: const Color(0xFF1E2B50), width: 1.5),
                              ),
                              child: ClipOval(
                                child: Image.asset(
                                  'assets/images/valeria.png', // Ganti dengan foto user yang sedang login
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => const Icon(Icons.person, size: 20, color: Color(0xFF1E2B50)),
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

            // ---------- INPUT CHAT DI BAGIAN BAWAH ----------
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        hintText: 'Ketik pesan...',
                        hintStyle: const TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: const BorderSide(color: Color(0xFF1E2B50)),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [Color(0xFF202F55), Color(0xFF4565B8)],
                      ),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.send, color: Colors.white, size: 20),
                      onPressed: _sendMessage,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}