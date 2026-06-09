part of data;

class ApiClient {
  // Base URL Universal untuk aplikasi Amazing Facts Indonesia
  final String _baseUrl = "https://api.amazingfactsindo.org";

  // Fungsi universal untuk mengambil data (GET Request) secara asinkron luar
  Future<http.Response> getRequest(String endpoint) async {
    final url = Uri.parse('$_baseUrl/$endpoint');
    
    try {
      // Menggunakan library http untuk komunikasi client-server
      final response = await http.get(url);
      return response; // Mengembalikan data response mentah ke Repository
    } catch (e) {
      // Mengatur sirkulasi respon dari sisi network jika gagal koneksi
      throw Exception("Gagal terhubung dengan pihak asyncron di luar server: $e");
    }
  }
}