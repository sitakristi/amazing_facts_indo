part of models;

class RenunganModel extends Equatable {
  final int id;
  final String judul;
  final String isi;
  final String tanggal;
  final String imageUrl;

  const RenunganModel({
    required this.id,
    required this.judul,
    required this.isi,
    required this.tanggal,
    required this.imageUrl,
  });

  // 🌟 BARU: Fungsi untuk mengubah URL gambar lokal MacBook di tingkat Repository
  RenunganModel copyWith({
    int? id,
    String? judul,
    String? isi,
    String? tanggal,
    String? imageUrl,
  }) {
    return RenunganModel(
      id: id ?? this.id,
      judul: judul ?? this.judul,
      isi: isi ?? this.isi,
      tanggal: tanggal ?? this.tanggal,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  @override
  List<Object?> get props => [id, judul, isi, tanggal, imageUrl];

  factory RenunganModel.fromJson(Map<String, dynamic> json) {
    return RenunganModel(
      id: json['id'] ?? 0,
      judul: json['title'] ?? '',      
      isi: json['content'] ?? '',      
      tanggal: json['date_display'] ?? '', 
      imageUrl: json['image_url'] ?? 'https://via.placeholder.com/150',
    );
  }
}