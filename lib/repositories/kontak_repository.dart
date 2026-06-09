part of repositories;

class KontakRepository {
  final String _apiUrl = 'http://localhost:8000/api/kontak';

  Future<KontakModel> getKontakInfo() async {
    try {
      final response = await http.get(Uri.parse(_apiUrl)).timeout(const Duration(seconds: 3));
      if (response.statusCode == 200) {
        return KontakModel.fromJson(json.decode(response.body));
      }
    } catch (e) {
      print("Koneksi ke Laravel belum siap, menggunakan data simulasi Kontak.");
    }

    return const KontakModel(
      nomorHotline: "628975821234",
      nomorHumas: "6285212341110",
      namaBank: "Bank Central Asia",
      nomorRekening: "3930283575",
      atasNama: "Amazing Facts Indonesia",
    );
  }
}