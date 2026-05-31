import '../models/user_model.dart';

class UserRepository {
  final List<UserModel> _fakeUserDatabase = [];

  // CREATE
  Future<void> createUser(UserModel user) async {
    await Future.delayed(const Duration(seconds: 2));
    _fakeUserDatabase.add(user);
  }

  // READ
  List<UserModel> getAllUsers() {
    return _fakeUserDatabase;
  }

  // UPDATE (Perbaikan Typo -of menjadi -1)
  Future<void> updateUser(String id, String namaBaru) async {
    await Future.delayed(const Duration(seconds: 1));
    final index = _fakeUserDatabase.indexWhere((u) => u.id == id);
    if (index != -1) {
      _fakeUserDatabase[index].namaLengkap = namaBaru;
    }
  }

  // DELETE
  Future<void> deleteUser(String id) async {
    await Future.delayed(const Duration(seconds: 1));
    _fakeUserDatabase.removeWhere((u) => u.id == id);
  }

  // Auth Check
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