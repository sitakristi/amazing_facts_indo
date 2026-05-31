import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../repositories/user_repository.dart';

class UserViewModel extends ChangeNotifier {
  final UserRepository _userRepository = UserRepository();
  UserModel? _currentUser;
  bool _isLoading = false;

  UserModel? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  List<UserModel> get allRegisteredUsers => _userRepository.getAllUsers();

  // Aksi CRUD - Create (Registrasi Akun)
  Future<bool> registerUser(String nama, String email, String password) async {
    _isLoading = true;
    notifyListeners();

    final newUser = UserModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      namaLengkap: nama,
      email: email,
      kataSandi: password,
    );

    await _userRepository.createUser(newUser);
    
    _isLoading = false;
    notifyListeners();
    return true;
  }

  // Aksi Simulasi Auth - Login
  Future<bool> loginUser(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));
    final user = _userRepository.loginCheck(email, password);

    _isLoading = false;
    if (user != null) {
      _currentUser = user;
      notifyListeners();
      return true;
    }
    notifyListeners();
    return false;
  }

  // FUNGSI LOGOUT USER: Membersihkan data sesi login secara total
  void logoutUser() {
    _currentUser = null; // Menghapus data jemaat yang sedang aktif
    notifyListeners();   // Memaksa seluruh UI (HomeScreen) memuat ulang tampilan
  }

  // Aksi CRUD - Update Profile Lengkap
  Future<void> updateProfileLengkap({
    required String id,
    required String nama,
    required String tglLahir,
    required String noTelp,
    required String alamat,
    required String email,
    required String password,
  }) async {
    _isLoading = true;
    notifyListeners();
    
    await Future.delayed(const Duration(seconds: 1)); // Simulasi proses simpan
    
    if (_currentUser != null && _currentUser!.id == id) {
      _currentUser!.namaLengkap = nama;
      _currentUser!.tanggalLahir = tglLahir;
      _currentUser!.nomorTelepon = noTelp;
      _currentUser!.alamat = alamat;
      _currentUser!.email = email;
      _currentUser!.kataSandi = password;
    }
    
    _isLoading = false;
    notifyListeners();
  }

  // Aksi CRUD - Delete Account
  Future<void> deleteAccount(String id) async {
    await _userRepository.deleteUser(id);
    if (_currentUser?.id == id) {
      _currentUser = null;
    }
    notifyListeners();
  }
}