part of repositories;

class VideoRepository {
  // 🌟 PERBAIKAN: Menggunakan konfigurasi satu pintu dari AppConfig
  final String _baseUrl = AppConfig.baseUrl;

  Future<List<VideoModel>> getVideos() async {
    try {
      // Menggabungkan dengan base url konfigurasimu
      final response = await http.get(Uri.parse('$_baseUrl/video')).timeout(const Duration(seconds: 15));
      
      if (response.statusCode == 200) {
        // Bongkar bungkus JSON response dari Laravel
        final Map<String, dynamic> responseData = json.decode(response.body);
        final List<dynamic> dataList = responseData['data'];
        
        return dataList.map((item) => VideoModel.fromJson(item)).toList();
      }
    } catch (e) {
      print("Koneksi ke Laravel terkendala: $e. Menggunakan data simulasi cadangan.");
    }

    // Tetap sediakan cadangan video tiruan jika server offline
    return const [
      VideoModel(
        id: 1,
        judul: "Nubuat Alkitab & Masa Depan Dunia",
        videoUrl: "https://www.youtube.com/watch?v=u9M0u8cK_m0",
        thumbnailUrl: "https://images.unsplash.com/photo-1516321318423-f06f85e504b3?w=500",
      ),
      VideoModel(
        id: 2,
        judul: "Menemukan Kedamaian di Tengah Badai Hidup",
        videoUrl: "https://www.youtube.com/watch?v=x8e_mY9bXwA",
        thumbnailUrl: "https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=500",
      ),
    ];
  }
}