import 'package:flutter/material.dart';
import '../models/video_model.dart';
import '../repositories/video_repository.dart';

class VideoViewModel extends ChangeNotifier {
  final VideoRepository _repository = VideoRepository();

  List<VideoModel> _daftarVideo = [];
  bool _isLoading = false;

  List<VideoModel> get daftarVideo => _daftarVideo;
  bool get isLoading => _isLoading;

  Future<void> fetchVideos() async {
    _isLoading = true;
    notifyListeners();

    try {
      _daftarVideo = await _repository.getVideos();
    } catch (e) {
      print("Gagal mengambil data video: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}