import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/renungan_model.dart';

class RenunganRepository {
  // Ini alamat API Laravel sesuai rancangan proposalmu
  final String _apiUrl = 'http://localhost:8000/api/renungan';

  Future<List<RenunganModel>> getRenungan() async {
    try {
      // Mencoba mengambil data asli dari server Laravel
      final response = await http.get(Uri.parse(_apiUrl)).timeout(const Duration(seconds: 3));
      
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((item) => RenunganModel.fromJson(item)).toList();
      }
    } catch (e) {
      // Jika server Laravel belum dinyalakan/error, otomatis pakai data simulasi di bawah ini
      print("Koneksi ke Laravel belum siap, menggunakan data simulasi Indonesia.");
    }

    // DATA SIMULASI (Sama konsepnya dengan aplikasi pusat Amerika, tapi Bahasa Indonesia)
    return [
      RenunganModel(
        id: 1,
        judul: "Berakar di Dalam Firman",
        isi: "Hari ini kita belajar bahwa hidup rohani yang kuat membutuhkan akar yang dalam pada Firman Tuhan, seperti pohon yang ditanam di tepi aliran air.",
        tanggal: "20 Mei 2026",
        imageUrl: "https://images.unsplash.com/photo-1504052434569-70ad5836ab65?w=500", // Gambar estetik Alkitab terbuka
      ),
      RenunganModel(
        id: 2,
        judul: "Pelita Bagi Jalanku",
        isi: "Firman-Mu adalah pelita bagi kakiku dan terang bagi jalanku. Di tengah kegelapan dunia, petunjuk Tuhan selalu memberikan kepastian.",
        tanggal: "19 Mei 2026",
        imageUrl: "https://images.unsplash.com/photo-1447069387593-a5de0862481e?w=500", // Gambar Alkitab klasik kuno yang sangat estetik
      ),
    ];
  }
}