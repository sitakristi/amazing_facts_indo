part of repositories;

class RenunganRepository {
  final String _baseUrl = AppConfig.baseUrl;

  // Ambil 1 Data Renungan Hari Ini (Objek Tunggal)
  Future<RenunganModel?> getRenunganHariIni() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/renungan/hari-ini')).timeout(const Duration(seconds: 15));
      
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        
        // Memastikan isi bungkus 'data' dari Laravel tidak kosong
        if (responseData['data'] != null) {
          final Map<String, dynamic> item = responseData['data'];
          
          // Memperbaiki jalur URL Gambar lokal server
          String imageUrl = item['image_url'] ?? '';
          if (imageUrl.isNotEmpty && !imageUrl.startsWith('http')) {
            final String baseStorage = _baseUrl.replaceAll('/api', '/storage');
            imageUrl = '$baseStorage/$imageUrl';
          }

          return RenunganModel.fromJson(item).copyWith(imageUrl: imageUrl);
        }
      }
    } catch (e) {
      print("Koneksi ke Laravel (Hari Ini) terkendala: $e");
    }
    return null;
  }

  // Ambil Semua Daftar Renungan (List/Array)
  Future<List<RenunganModel>> getRenungan() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/renungan')).timeout(const Duration(seconds: 15));
      
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final List<dynamic> dataList = responseData['data'] ?? [];
        
        return dataList.map((item) {
          String imageUrl = item['image_url'] ?? '';
          if (imageUrl.isNotEmpty && !imageUrl.startsWith('http')) {
            final String baseStorage = _baseUrl.replaceAll('/api', '/storage');
            imageUrl = '$baseStorage/$imageUrl';
          }
          return RenunganModel.fromJson(item).copyWith(imageUrl: imageUrl);
        }).toList();
      }
    } catch (e) {
      print("Koneksi ke Laravel (Daftar Arsip) terkendala: $e");
    }
    return const [];
  }
}