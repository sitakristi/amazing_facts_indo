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

  @override
  List<Object?> get props => [id, judul, isi, tanggal, imageUrl];

  factory RenunganModel.fromJson(Map<String, dynamic> json) {
    return RenunganModel(
      id: json['id'] ?? 0,
      judul: json['judul'] ?? '',
      isi: json['isi'] ?? '',
      tanggal: json['tanggal'] ?? '',
      imageUrl: json['image_url'] ?? 'https://via.placeholder.com/150',
    );
  }
}