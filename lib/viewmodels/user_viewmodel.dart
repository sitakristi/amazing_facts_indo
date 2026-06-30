part of viewmodels;

class UserViewModel extends ChangeNotifier {
  final UserRepository _userRepository = UserRepository();
  UserModel? _currentUser;
  String? _token; 
  bool _isLoading = false;

  UserModel? get currentUser => _currentUser;
  String? get token => _token;
  bool get isLoading => _isLoading;

  List<UserModel> get allRegisteredUsers => _userRepository.getAllUsers();

  Future<bool> registerUser(String nama, String email, String password) async {
    _isLoading = true;
    notifyListeners();

    final newUser = UserModel(
      id: '',
      namaLengkap: nama,
      email: email,
      kataSandi: password,
    );

    final result = await _userRepository.createUser(newUser);

    _isLoading = false;
    notifyListeners();
    return result['success'] ?? false;
  }

  // 🌟 FUNGSI LOGIN (Memastikan UI langsung berubah begitu sukses)
  Future<bool> loginUser(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    final result = await _userRepository.loginCheck(email, password);

    if (result['success'] == true) {
      _token = result['token']; 
      final userData = result['user'];
      
      _currentUser = UserModel(
        id: userData['id'].toString(),
        namaLengkap: userData['name'] ?? '',
        email: userData['email'] ?? '',
        kataSandi: password,
        nomorTelepon: userData['phone'] ?? '-',   
        alamat: userData['address'] ?? '-',       
      );

      _isLoading = false;
      notifyListeners(); // 🌟 Memicu HomeScreen untuk mengubah tombol "Masuk" jadi Profil Akun
      return true;
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }

  void logoutUser() {
    _currentUser = null;
    _token = null; 
    notifyListeners(); 
  }

  Future<bool> updateProfileLengkap({
    required String id,
    required String nama,
    required String tglLahir,
    required String noTelp,
    required String alamat,
    required String email,
    required String password,
  }) async {
    if (_token == null) return false;

    _isLoading = true;
    notifyListeners();

    final result = await _userRepository.updateUserLengkap(
      token: _token!,
      nama: nama,
      nomorTelepon: noTelp,
      alamat: alamat,
    );

    if (result['success'] == true) {
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
      return true;
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }
}