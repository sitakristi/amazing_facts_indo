// lib/repositories/kontak_repository.dart
part of repositories;

class KontakRepository {
  // Ganti localhost dengan IP MacBook kamu dan pastikan routenya '/api/contact'
  final String _apiUrl = 'http://192.168.18.36:8000/api/contact';

  Future<KontakModel> getKontakInfo() async {
    try {
      final response = await http.get(Uri.parse(_apiUrl)).timeout(const Duration(seconds: 15));
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['success'] == true) {
          // Kirim data bagian dalam ['data'] ke fungsi objek parser model
          return KontakModel.fromJson(responseData['data']);
        }
      }
    } catch (e) {
      print("Koneksi ke Laravel belum siap atau bermasalah: $e");
    }

    // Tetap gunakan data simulasi cadangan ini jika jaringan down
    return const KontakModel(
      nomorHotline: "6281234567890",
      nomorHumas: "6289876543210",
      namaBank: "Bank Central Asia",
      nomorRekening: "3930283575",
      atasNama: "Amazing Facts Indonesia",
    );
  }
}