part of repositories;

class RenunganRepository {
  final String _apiUrl = 'http://localhost:8000/api/renungan';

  Future<List<RenunganModel>> getRenungan() async {
    try {
      final response = await http.get(Uri.parse(_apiUrl)).timeout(const Duration(seconds: 3));
      
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((item) => RenunganModel.fromJson(item)).toList();
      }
    } catch (e) {
      print("Koneksi ke Laravel belum siap, menggunakan data simulasi Indonesia.");
    }

    return const [
      RenunganModel(
        id: 1,
        judul: "Berakar di Inside Firman",
        isi: "Hari ini kita belajar bahwa hidup rohani yang kuat membutuhkan akar yang dalam pada Firman Tuhan, seperti pohon yang ditanam di tepi aliran air.",
        tanggal: "20 Mei 2026",
        imageUrl: "https://images.unsplash.com/photo-1504052434569-70ad5836ab65?w=500",
      ),
      RenunganModel(
        id: 2,
        judul: "Pelita Bagi Jalanku",
        isi: "Firman-Mu adalah pelita bagi kakiku dan terang bagi jalanku. Di tengah kegelapan dunia, petunjuk Tuhan selalu memberikan kepastian.",
        tanggal: "19 Mei 2026",
        imageUrl: "https://images.unsplash.com/photo-1447069387593-a5de0862481e?w=500",
      ),
    ];
  }
}