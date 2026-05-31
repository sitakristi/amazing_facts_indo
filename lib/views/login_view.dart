import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/user_viewmodel.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  void _handleLogin(UserViewModel viewModel) async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Semua kolom harus diisi!"), backgroundColor: Colors.red),
      );
      return;
    }

    // Menampilkan dialog loading kustom MVVM
    _showLoadingDialog();

    final sukses = await viewModel.loginUser(email, password);
    
    Navigator.pop(context); // Tutup loading dialog

    if (sukses) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Selamat Datang, ${viewModel.currentUser?.namaLengkap}!"),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context); // Kembali ke HomeScreen setelah sukses login
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Email atau Kata Sandi salah!"), backgroundColor: Colors.red),
      );
    }
  }

  void _showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: Card(
          color: Color(0xFF1B263B),
          child: Padding(
            padding: EdgeInsets.all(25.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFBC02D))),
                SizedBox(height: 16),
                Text("Memverifikasi Akun...", style: TextStyle(color: Colors.white, fontSize: 14, decoration: TextDecoration.none)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color afDarkBackground = Color(0xFF0D1B2A);
    const Color afGold = Color(0xFFFBC02D);

    return Scaffold(
      backgroundColor: afDarkBackground,
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0, iconTheme: const IconThemeData(color: Colors.white)),
      body: Consumer<UserViewModel>(
        builder: (context, userVM, child) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Center(
                  child: Image.asset('assets/images/logo.png', height: 100, 
                    errorBuilder: (c,e,s) => const Icon(Icons.auto_stories, color: afGold, size: 80)),
                ),
                const SizedBox(height: 40),
                const Text("Selamat Datang Kembali", style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                const Text("Silakan masuk untuk melanjutkan perjalanan rohani Anda.", style: TextStyle(color: Colors.white70, fontSize: 14)),
                const SizedBox(height: 40),
                
                TextField(
                  controller: _emailController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: "Email",
                    labelStyle: TextStyle(color: afGold),
                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white24)),
                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: afGold)),
                    prefixIcon: Icon(Icons.email_outlined, color: afGold),
                  ),
                ),
                const SizedBox(height: 20),
                
                TextField(
                  controller: _passwordController,
                  obscureText: !_isPasswordVisible,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: "Kata Sandi",
                    labelStyle: const TextStyle(color: afGold),
                    enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.white24)),
                    focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: afGold)),
                    prefixIcon: const Icon(Icons.lock_outline, color: afGold),
                    suffixIcon: IconButton(
                      icon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off, color: Colors.white54),
                      onPressed: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
                    ),
                  ),
                ),
                
                const SizedBox(height: 45),
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: afGold, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                    onPressed: () => _handleLogin(userVM),
                    child: const Text("MASUK", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                ),
                
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Belum punya akun?", style: TextStyle(color: Colors.white70)),
                    TextButton(
                      onPressed: () => Navigator.pop(context), 
                      child: const Text("Daftar Sekarang", style: TextStyle(color: afGold, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}