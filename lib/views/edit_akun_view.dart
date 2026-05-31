import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/user_viewmodel.dart';

class EditAkunView extends StatefulWidget {
  const EditAkunView({Key? key}) : super(key: key);

  @override
  _EditAkunViewState createState() => _EditAkunViewState();
}

class _EditAkunViewState extends State<EditAkunView> {
  final _namaController = TextEditingController();
  final _tglLahirController = TextEditingController();
  final _noTelpController = TextEditingController();
  final _alamatController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final user = context.read<UserViewModel>().currentUser;
    if (user != null) {
      _namaController.text = user.namaLengkap;
      _tglLahirController.text = user.tanggalLahir;
      _noTelpController.text = user.nomorTelepon;
      _alamatController.text = user.alamat;
      _emailController.text = user.email;
      _passwordController.text = user.kataSandi;
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color afDarkBackground = Color(0xFF0D1B2A);
    const Color afGold = Color(0xFFFBC02D);

    return Scaffold(
      backgroundColor: afDarkBackground,
      appBar: AppBar(
        title: const Text("Edit Profil Pengguna", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF050C1A),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Consumer<UserViewModel>(
        builder: (context, userVM, child) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Mengganti tumpukan lingkaran foto dengan teks header yang bersih
                const Text(
                  "Informasi Akun",
                  style: TextStyle(color: afGold, fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 0.5),
                ),
                const SizedBox(height: 4),
                const Text(
                  "Silakan perbarui data profil Anda di bawah ini jika terdapat perubahan.",
                  style: TextStyle(color: Colors.white54, fontSize: 12),
                ),
                const SizedBox(height: 24),
                
                // Form input data teks pengguna
                _buildField("Nama Lengkap", _namaController, Icons.person_outline),
                _buildField("Tanggal Lahir", _tglLahirController, Icons.calendar_today_outlined),
                _buildField("No. Telepon", _noTelpController, Icons.phone_android_outlined),
                _buildField("Alamat Tinggal", _alamatController, Icons.home_outlined),
                _buildField("Email", _emailController, Icons.email_outlined),
                _buildField("Kata Sandi", _passwordController, Icons.lock_outline, obscure: true),
                const SizedBox(height: 32),
                
                // Tombol Simpan Perubahan
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: afGold, 
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                    ),
                    onPressed: () async {
                      await userVM.updateProfileLengkap(
                        id: userVM.currentUser!.id,
                        nama: _namaController.text,
                        tglLahir: _tglLahirController.text,
                        noTelp: _noTelpController.text,
                        alamat: _alamatController.text,
                        email: _emailController.text,
                        password: _passwordController.text,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Profil berhasil diperbarui!"), backgroundColor: Colors.green),
                      );
                      Navigator.pop(context);
                    },
                    child: const Text("SIMPAN PERUBAHAN", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildField(String label, TextEditingController controller, IconData icon, {bool obscure = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Color(0xFFFBC02D), fontSize: 13),
          enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.white24)),
          focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFFBC02D))),
          prefixIcon: Icon(icon, color: const Color(0xFFFBC02D), size: 20),
        ),
      ),
    );
  }
}