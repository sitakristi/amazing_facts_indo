part of models;

class VideoModel extends Equatable {
  final int id;
  final String judul;
  final String videoUrl;
  final String thumbnailUrl;

  const VideoModel({
    required this.id,
    required this.judul,
    required this.videoUrl,
    required this.thumbnailUrl,
  });

  @override
  List<Object?> get props => [id, judul, videoUrl, thumbnailUrl];

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    final String youtubeId = json['youtube_id'] ?? '';

    return VideoModel(
      id: json['id'] ?? 0,
      judul: json['title'] ?? '',
      // Diubah kembali menjadi link YouTube utuh agar tombol di UI bisa membukanya
      videoUrl: youtubeId.isNotEmpty 
          ? 'https://www.youtube.com/watch?v=$youtubeId' 
          : '',
      thumbnailUrl: youtubeId.isNotEmpty 
          ? 'https://img.youtube.com/vi/$youtubeId/0.jpg' 
          : 'https://via.placeholder.com/150',
    );
  }
}