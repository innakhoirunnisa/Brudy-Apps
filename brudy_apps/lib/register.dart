import 'package:flutter/material.dart';
import 'lengkapi_profil.dart';

void main() {
  runApp(const BrudyApp());
}

/// ===================== WARNA =====================
class AppColors {
  static const background = Color(0xFFE6E8F1); // latar belakang abu kebiruan
  static const title = Color(0xFF1E2B50); // judul & border input
  static const label = Color(0xFF4A5578); // label & teks sekunder
  static const gradientStart = Color(0xFF202F55); // tombol (kiri)
  static const gradientEnd = Color(0xFF4565B8); // tombol (kanan)
}

/// ===================== APP ROOT =====================
class BrudyApp extends StatelessWidget {
  const BrudyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BRUDYs',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.background,
      ),
      home: const LoginPage(),
    );
  }
}

/// ===================== HALAMAN LOGIN =====================
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;
    setState(() => _isLoading = false);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Login sebagai ${_emailController.text}')),
    );
  }

  void _goToRegister() {
    // Navigasi ke halaman Buat Akun (RegisterPage)
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const RegisterPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // ---------- Logo ----------
                    Center(
                      child: Image.asset(
                        'assets/images/logo_brudy.png',
                        width: 124,
                        height: 124,
                        errorBuilder: (_, __, ___) => const Icon(
                          Icons.school,
                          size: 100,
                          color: AppColors.title,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // ---------- Judul ----------
                    const Text(
                      'Login',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w800,
                        color: AppColors.title,
                      ),
                    ),
                    const SizedBox(height: 40),

                    // ---------- Email / Username ----------
                    const _FieldLabel('Email Kampus / Username'),
                    const SizedBox(height: 8),
                    _RoundedField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      validator: (v) => (v == null || v.trim().isEmpty)
                          ? 'Email / username wajib diisi'
                          : null,
                    ),
                    const SizedBox(height: 20),

                    // ---------- Password ----------
                    const _FieldLabel('Password'),
                    const SizedBox(height: 8),
                    _RoundedField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      textInputAction: TextInputAction.done,
                      onSubmitted: (_) => _handleLogin(),
                      validator: (v) => (v == null || v.isEmpty)
                          ? 'Password wajib diisi'
                          : null,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: AppColors.label,
                        ),
                        onPressed: () => setState(
                          () => _obscurePassword = !_obscurePassword,
                        ),
                      ),
                    ),
                    const SizedBox(height: 56),

                    // ---------- Tombol Login ----------
                    _GradientButton(
                      text: 'Login',
                      isLoading: _isLoading,
                      onPressed: _isLoading ? null : _handleLogin,
                    ),
                    const SizedBox(height: 24),

                    // ---------- Buat Akun ----------
                    const Text(
                      'Belum Punya Akun?',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: AppColors.label),
                    ),
                    const SizedBox(height: 4),
                    Center(
                      child: GestureDetector(
                        onTap: _goToRegister,
                        child: const Text(
                          'Buat Akun',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.italic,
                            decoration: TextDecoration.underline,
                            decorationColor: AppColors.label,
                            color: AppColors.label,
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
      ),
    );
  }
}

/// ===================== HALAMAN REGISTER (BUAT AKUN) =====================
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _namaController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  
  // Controller untuk 4 digit Kode Verifikasi OTP
  final List<TextEditingController> _otpControllers =
      List.generate(4, (_) => TextEditingController());
      
  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _namaController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _handleRegister() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;
    setState(() => _isLoading = false);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LengkapiProfilPage()),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Registrasi Berhasil! Silakan Verifikasi.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.title),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
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
                          color: AppColors.title,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // ---------- Judul ----------
                    const Text(
                      'Buat Akun',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.w800,
                        color: AppColors.title,
                      ),
                    ),
                    const SizedBox(height: 30),

                    // ---------- Email / No Telp ----------
                    const _FieldLabel('Email / No. Telp'),
                    const SizedBox(height: 6),
                    _RoundedField(
                      controller: _emailController,
                      textInputAction: TextInputAction.next,
                      validator: (v) => (v == null || v.trim().isEmpty)
                          ? 'Email atau No. Telp wajib diisi'
                          : null,
                    ),
                    const SizedBox(height: 16),

                    // ---------- Nama Lengkap ----------
                    const _FieldLabel('Nama Lengkap'),
                    const SizedBox(height: 6),
                    _RoundedField(
                      controller: _namaController,
                      textInputAction: TextInputAction.next,
                      validator: (v) => (v == null || v.trim().isEmpty)
                          ? 'Nama lengkap wajib diisi'
                          : null,
                    ),
                    const SizedBox(height: 16),

                    // ---------- Username ----------
                    const _FieldLabel('Username'),
                    const SizedBox(height: 6),
                    _RoundedField(
                      controller: _usernameController,
                      textInputAction: TextInputAction.next,
                      validator: (v) => (v == null || v.trim().isEmpty)
                          ? 'Username wajib diisi'
                          : null,
                    ),
                    const SizedBox(height: 16),

                    // ---------- Password ----------
                    const _FieldLabel('Password'),
                    const SizedBox(height: 6),
                    _RoundedField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      textInputAction: TextInputAction.next,
                      validator: (v) => (v == null || v.isEmpty)
                          ? 'Password wajib diisi'
                          : null,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: AppColors.label,
                        ),
                        onPressed: () => setState(
                          () => _obscurePassword = !_obscurePassword,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // ---------- Kode Verifikasi (OTP 4 Digit) ----------
                    const _FieldLabel('Kode Verifikasi'),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(4, (index) => _buildOtpBox(index)),
                    ),
                    const SizedBox(height: 6),
                    const Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        '*kode akan dikirim melalui email kampusmu',
                        style: TextStyle(
                          color: AppColors.label,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const SizedBox(height: 36),

                    // ---------- Tombol Verifikasi & Lanjut ----------
                    _GradientButton(
                      text: 'Verifikasi & Lanjut',
                      isLoading: _isLoading,
                      onPressed: _isLoading ? null : _handleRegister,
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Widget Kotak OTP Individual
  Widget _buildOtpBox(int index) {
    return SizedBox(
      width: 70,
      child: TextFormField(
        controller: _otpControllers[index],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: AppColors.title,
        ),
        cursorColor: AppColors.title,
        decoration: InputDecoration(
          counterText: "",
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: const BorderSide(color: AppColors.title, width: 1.2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: const BorderSide(color: AppColors.title, width: 2),
          ),
        ),
        onChanged: (value) {
          if (value.isNotEmpty && index < 3) {
            FocusScope.of(context).nextFocus();
          } else if (value.isEmpty && index > 0) {
            FocusScope.of(context).previousFocus();
          }
        },
      ),
    );
  }
}

/// ===================== KOMPONEN =====================

/// Label di atas input
class _FieldLabel extends StatelessWidget {
  final String text;
  const _FieldLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Text(
        text,
        style: const TextStyle(fontSize: 17, color: AppColors.label),
      ),
    );
  }
}

/// Input putih dengan sudut membulat & border biru tua
class _RoundedField extends StatelessWidget {
  final TextEditingController controller;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  final void Function(String)? onSubmitted;
  final Widget? suffixIcon;

  const _RoundedField({
    required this.controller,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.validator,
    this.onSubmitted,
    this.suffixIcon,
  });

  OutlineInputBorder _border(Color color, [double width = 1.2]) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(28),
        borderSide: BorderSide(color: color, width: width),
      );

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      onFieldSubmitted: onSubmitted,
      validator: validator,
      style: const TextStyle(fontSize: 16, color: AppColors.title),
      cursorColor: AppColors.title,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        suffixIcon: suffixIcon,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 22,
          vertical: 18,
        ),
        enabledBorder: _border(AppColors.title),
        focusedBorder: _border(AppColors.title, 2),
        errorBorder: _border(Colors.red.shade700),
        focusedErrorBorder: _border(Colors.red.shade700, 2),
      ),
    );
  }
}

/// Tombol dengan gradasi kiri (gelap) -> kanan (biru terang)
class _GradientButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;

  const _GradientButton({
    required this.text,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [AppColors.gradientStart, AppColors.gradientEnd],
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(30),
          onTap: onPressed,
          child: Center(
            child: isLoading
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      color: Colors.white,
                    ),
                  )
                : Text(
                    text,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}