import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/kontak_model.dart';

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

    // DATA SIMULASI KONTAK (Sesuai dengan nomor yang ada di proposal MVP kamu)
    return KontakModel(
      nomorHotline: "628975821234", // Format kode negara Indonesia tanpa tanda + untuk WhatsApp
      nomorHumas: "6285212341110",
      namaBank: "Bank Central Asia",
      nomorRekening: "3930283575",
      atasNama: "Amazing Facts Indonesia",
    );
  }
}