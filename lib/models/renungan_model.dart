class RenunganModel {
  final int id;
  final String judul;
  final String isi;
  final String tanggal;
  final String imageUrl; // Di aplikasi pusat AS menggunakan visual gambar, kita siapkan variabelnya di sini

  // Ini adalah konstruktor untuk merakit data saat aplikasi dijalankan
  RenunganModel({
    required this.id,
    required this.judul,
    required this.isi,
    required this.tanggal,
    required this.imageUrl,
  });

  // Ini fungsi penerjemah agar data teks JSON dari server Laravel bisa dibaca oleh Flutter
  factory RenunganModel.fromJson(Map<String, dynamic> json) {
    return RenunganModel(
      id: json['id'],
      judul: json['judul'],
      isi: json['isi'],
      tanggal: json['tanggal'],
      imageUrl: json['image_url'] ?? 'https://via.placeholder.com/150', // Menggunakan gambar cadangan jika kosong
    );
  }
}