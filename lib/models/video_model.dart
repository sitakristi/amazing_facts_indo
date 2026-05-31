class VideoModel {
  final int id;
  final String judul;
  final String videoUrl; // Link YouTube yang akan memicu Deep Linking ke aplikasi YouTube asli
  final String thumbnailUrl; // Gambar pratinjau kartu video agar estetikanya mirip versi US

  VideoModel({
    required this.id,
    required this.judul,
    required this.videoUrl,
    required this.thumbnailUrl,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      id: json['id'],
      judul: json['judul'],
      videoUrl: json['video_url'],
      thumbnailUrl: json['thumbnail_url'] ?? 'https://via.placeholder.com/150',
    );
  }
}