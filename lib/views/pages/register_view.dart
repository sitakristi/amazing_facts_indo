// lib/views/pages/register_view.dart
part of pages;

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  void _handleRegister(UserViewModel viewModel) async {
    final nama = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (nama.isEmpty || email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Semua kolom wajib diisi!"), backgroundColor: Colors.red),
      );
      return;
    }

    _showLoadingDialog();

    await viewModel.registerUser(nama, email, password);

    Navigator.pop(context); 

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Pendaftaran Berhasil! Selamat bergabung dalam komunitas Amazing Facts Indonesia."),
        backgroundColor: Colors.green,
      ),
    );

    Navigator.pop(context); 
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
                Text("Menyimpan Data Jemaat...", style: TextStyle(color: Colors.white, fontSize: 14, decoration: TextDecoration.none)),
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
                const Text("Buat Akun Baru", style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                const Text("Mari bergabung dalam pelayanan pekabaran kebenaran Allah.", style: TextStyle(color: Colors.white70, fontSize: 14)),
                const SizedBox(height: 40),
                
                // Mengganti form pendaftaran dengan widget kustom modular secara instan
                CustomInputField(
                  labelText: "Nama Lengkap",
                  icon: Icons.person_outline,
                  controller: _nameController,
                ),
                
                CustomInputField(
                  labelText: "Email",
                  icon: Icons.email_outlined,
                  controller: _emailController,
                ),
                
                CustomInputField(
                  labelText: "Kata Sandi",
                  icon: Icons.lock_outline,
                  controller: _passwordController,
                  isPassword: !_isPasswordVisible,
                  suffixIcon: IconButton(
                    icon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off, color: Colors.white54),
                    onPressed: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
                  ),
                ),
                
                const SizedBox(height: 50),
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: afGold, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                    onPressed: () => _handleRegister(userVM),
                    child: const Text("DAFTAR", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                ),
                
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Sudah memiliki akun?", style: TextStyle(color: Colors.white70)),
                    TextButton(
                      onPressed: () => Navigator.pop(context), 
                      child: const Text("Masuk Sini", style: TextStyle(color: afGold, fontWeight: FontWeight.bold)),
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