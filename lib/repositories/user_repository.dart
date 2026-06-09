part of repositories;

class UserRepository {
  final List<UserModel> _fakeUserDatabase = [];

  Future<void> createUser(UserModel user) async {
    await Future.delayed(const Duration(seconds: 2));
    _fakeUserDatabase.add(user);
  }

  List<UserModel> getAllUsers() {
    return _fakeUserDatabase;
  }

  Future<void> updateUser(String id, String namaBaru) async {
    await Future.delayed(const Duration(seconds: 1));
    final index = _fakeUserDatabase.indexWhere((u) => u.id == id);
    if (index != -1) {
      _fakeUserDatabase[index] = UserModel(
        id: _fakeUserDatabase[index].id,
        namaLengkap: namaBaru,
        email: _fakeUserDatabase[index].email,
        kataSandi: _fakeUserDatabase[index].kataSandi,
        tanggalLahir: _fakeUserDatabase[index].tanggalLahir,
        nomorTelepon: _fakeUserDatabase[index].nomorTelepon,
        alamat: _fakeUserDatabase[index].alamat,
      );
    }
  }

  Future<void> deleteUser(String id) async {
    await Future.delayed(const Duration(seconds: 1));
    _fakeUserDatabase.removeWhere((u) => u.id == id);
  }

  UserModel? loginCheck(String email, String password) {
    try {
      return _fakeUserDatabase.firstWhere(
        (u) => u.email == email && u.kataSandi == password
      );
    } catch (e) {
      return null;
    }
  }
}