import 'package:flutter/material.dart';
import '../models/renungan_model.dart';
import '../repositories/renungan_repository.dart';

class RenunganViewModel extends ChangeNotifier {
  // Kita siapkan objek kurir (Repository) untuk mengambil data
  final RenunganRepository _repository = RenunganRepository();

  // Ini adalah wadah untuk menyimpan daftar renungan
  List<RenunganModel> _daftarRenungan = [];
  
  // Ini adalah indikator status loading (untuk memunculkan muter-muter loading di UI)
  bool _isLoading = false;

  // Fungsi agar halaman View (UI) bisa mengintip data renungan
  List<RenunganModel> get daftarRenungan => _daftarRenungan;
  bool get isLoading => _isLoading;

  // Fungsi utama untuk mengambil data renungan
  Future<void> fetchRenungan() async {
    _isLoading = true;
    notifyListeners(); // Kasih tahu UI untuk nampilin animasi loading

    try {
      // Menyuruh repository mengambil data (baik dari Laravel atau data simulasi)
      _daftarRenungan = await _repository.getRenungan();
    } catch (e) {
      print("Gagal mengambil data renungan: $e");
    } finally {
      _isLoading = false;
      notifyListeners(); // Kasih tahu UI bahwa loading selesai dan data siap ditampilkan!
    }
  }
}