// lib/viewmodels/user_viewmodel.dart
part of viewmodels;

class UserViewModel extends ChangeNotifier {
  final UserRepository _userRepository = UserRepository();
  UserModel? _currentUser;
  bool _isLoading = false;

  UserModel? get currentUser => _currentUser;
  bool get isLoading => _isLoading;

  List<UserModel> get allRegisteredUsers => _userRepository.getAllUsers();

  // Fungsi memproses registrasi jemaat baru ke repositori lokal
  Future<void> registerUser(String nama, String email, String password) async {
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
  }

  // Fungsi memproses pemeriksaan kredensial akun login
  Future<bool> loginUser(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1)); // Efek simulasi asinkron luar
    final user = _userRepository.loginCheck(email, password);

    if (user != null) {
      _currentUser = user;
      _isLoading = false;
      notifyListeners();
      return true;
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }

  // Fungsi membersihkan sesi otentikasi (Logout)
  void logoutUser() {
    _currentUser = null;
    notifyListeners(); // Memaksa seluruh UI (HomeScreen) memuat ulang tampilan kembali bersih
  }

  // Perbaikan fungsi update profil lengkap yang sesuai dengan Model Equatable (Final properti)
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

    // Memperbarui repositori data lokal
    await _userRepository.updateUser(id, nama);

    // Membuat ulang objek baru karena properti UserModel bermutasi menjadi final (Equatable)
    _currentUser = UserModel(
      id: id,
      namaLengkap: nama,
      email: email,
      kataSandi: password,
      tanggalLahir: tglLahir,
      nomorTelepon: noTelp,
      alamat: alamat,
    );

    _isLoading = false;
    notifyListeners();
  }
}