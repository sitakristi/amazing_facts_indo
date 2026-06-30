part of pages;

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  // 🌟 FUNGSI UTAMA: Menangani alur verifikasi login ke Laravel
  void _handleLogin(UserViewModel viewModel) async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    // 1. Validasi Input Lokal
    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Semua kolom harus diisi!"), 
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // 2. Tampilkan Pop-up Loading Animasi Muter
    _showLoadingDialog();

    // 3. Ketuk Pintu API Laravel Port 8080
    final sukses = await viewModel.loginUser(email, password);
    
    // 4. Tutup Dialog Loading Setelah Mendapat Respons dari Server
    if (!mounted) return;
    Navigator.pop(context); 

    // 5. Pengondisian Hasil Respons Auth Laravel
    if (sukses) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Selamat Datang, ${viewModel.currentUser?.namaLengkap}!"),
          backgroundColor: Colors.green,
        ),
      );
      
      // Tendang balik ke HomeScreen dengan State Drawer yang otomatis berubah
      if (mounted) Navigator.pop(context); 
    } else {
      // Peringatan jika data mismatch / email tidak cocok di database SQLite
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Email atau Kata Sandi salah! Periksa kembali tabel 'users' Anda."), 
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // 🌟 FUNGSI PEMBANTU: Dialog Loading Kustom
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
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFBC02D)),
                ),
                SizedBox(height: 16),
                Text(
                  "Memverifikasi Akun...", 
                  style: TextStyle(
                    color: Colors.white, 
                    fontSize: 14, 
                    decoration: TextDecoration.none,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Color afDarkBackground = Color(0xFF0D1B2A);
    const Color afGold = Color(0xFFFBC02D);

    return Scaffold(
      backgroundColor: afDarkBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent, 
        elevation: 0, 
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Consumer<UserViewModel>(
        builder: (context, userVM, child) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Center(
                  child: Image.asset(
                    'assets/images/logo.png', 
                    height: 100, 
                    errorBuilder: (c, e, s) => const Icon(
                      Icons.auto_stories, 
                      color: afGold, 
                      size: 80,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                const Text(
                  "Selamat Datang Kembali", 
                  style: TextStyle(
                    color: Colors.white, 
                    fontSize: 28, 
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Silakan masuk untuk melanjutkan perjalanan rohani Anda.", 
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
                const SizedBox(height: 40),
                
                // Input Email
                CustomInputField(
                  labelText: "Email",
                  icon: Icons.email_outlined,
                  controller: _emailController,
                ),
                
                // Input Password
                CustomInputField(
                  labelText: "Kata Sandi",
                  icon: Icons.lock_outline,
                  controller: _passwordController,
                  isPassword: !_isPasswordVisible,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible ? Icons.visibility : Icons.visibility_off, 
                      color: Colors.white54,
                    ),
                    onPressed: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
                  ),
                ),
                
                const SizedBox(height: 45),
                
                // Tombol Submit Masuk
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: afGold, 
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: () => _handleLogin(userVM),
                    child: const Text(
                      "MASUK", 
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                ),
                
                const SizedBox(height: 30),
                
                // Navigasi Pindah ke Register
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Belum punya akun? ", style: TextStyle(color: Colors.white70)),
                    TextButton(
                      onPressed: () => Navigator.pop(context), 
                      child: const Text(
                        "Daftar Sekarang", 
                        style: TextStyle(color: afGold, fontWeight: FontWeight.bold),
                      ),
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