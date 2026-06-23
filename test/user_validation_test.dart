import 'package:flutter_test/flutter_test.dart';
import 'package:amazing_facts_indo/viewmodels/viewmodels.dart';

void main() {
  group('Unit Testing - Validasi Input Registrasi Akun Jemaat', () {
    late UserViewModel userViewModel;

    setUp(() {
      userViewModel = UserViewModel();
    });

    test('Fungsi registerUser harus menolak pendaftaran jika ada kolom teks yang kosong', () async {
      // 1. ARRANGE
      const namaKosong = '';
      const emailValid = 'jemaat@email.com';
      const passwordValid = 'amazing123';

      // 2. ACT
      await userViewModel.registerUser(namaKosong, emailValid, passwordValid);

      // 3. ASSERT
      expect(userViewModel.currentUser, isNull);
    });

    test('Fungsi registerUser harus sukses menambahkan data pengguna baru ke dalam Repositori', () async {
      // 1. ARRANGE
      const namaValid = 'Rasita Christy';
      const emailValid = 'rasitachristy@email.com';
      const passwordValid = 'kebenaran2026';

      // Hitung jumlah jemaat awal sebelum registrasi dilakukan
      final jumlahAwal = userViewModel.allRegisteredUsers.length;

      // 2. ACT
      await userViewModel.registerUser(namaValid, emailValid, passwordValid);

      // 3. ASSERT
      // Verifikasi bahwa jumlah pengguna di repositori sekarang bertambah 1
      expect(userViewModel.allRegisteredUsers.length, equals(jumlahAwal + 1));
      
      // Memastikan jemaat yang baru didaftarkan datanya cocok di dalam list repositori
      final userBaru = userViewModel.allRegisteredUsers.last;
      expect(userBaru.namaLengkap, equals(namaValid));
      expect(userBaru.email, equals(emailValid));
    });
  });
}