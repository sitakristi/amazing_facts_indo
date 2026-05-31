import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/video_model.dart';

class VideoRepository {
  final String _apiUrl = 'http://localhost:8000/api/videos';

  Future<List<VideoModel>> getVideos() async {
    try {
      final response = await http.get(Uri.parse(_apiUrl)).timeout(const Duration(seconds: 3));
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((item) => VideoModel.fromJson(item)).toList();
      }
    } catch (e) {
      print("Koneksi ke Laravel belum siap, menggunakan data simulasi Video.");
    }

    // DATA SIMULASI VIDEO (Sesuai gaya tata letak Media Library & AFTV versi US)
    return [
      VideoModel(
        id: 1,
        judul: "Nubuat Alkitab & Masa Depan Dunia",
        videoUrl: "https://www.youtube.com/watch?v=dQw4w9WgXcQ", // Link YouTube asli yang akan di-Deep Link
        thumbnailUrl: "https://images.unsplash.com/photo-1516321318423-f06f85e504b3?w=500", // Gambar representasi teknologi/media
      ),
      VideoModel(
        id: 2,
        judul: "Menemukan Kedamaian di Tengah Badai Hidup",
        videoUrl: "https://www.youtube.com/watch?v=dQw4w9WgXcQ",
        thumbnailUrl: "https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=500", // Gambar pemandangan tenang
      ),
    ];
  }
}