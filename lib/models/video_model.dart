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
    return VideoModel(
      id: json['id'] ?? 0,
      judul: json['judul'] ?? '',
      videoUrl: json['video_url'] ?? '',
      thumbnailUrl: json['thumbnail_url'] ?? 'https://via.placeholder.com/150',
    );
  }
}