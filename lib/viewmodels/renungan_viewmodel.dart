part of viewmodels;

class RenunganViewModel extends ChangeNotifier {
  // Siapkan objek kurir (Repository) untuk mengambil data
  final RenunganRepository _repository = RenunganRepository();

  // Wadah untuk menyimpan daftar renungan lengkap (arsip)
  List<RenunganModel> _daftarRenungan = [];
  
  // Wadah khusus untuk menyimpan 1 data renungan hari ini
  RenunganModel? _renunganHariIni;
  
  // Ini adalah indikator status loading
  bool _isLoading = false;

  // Fungsi agar halaman View (UI) bisa mengintip data
  List<RenunganModel> get daftarRenungan => _daftarRenungan;
  RenunganModel? get renunganHariIni => _renunganHariIni; // 🌟 Getter baru
  bool get isLoading => _isLoading;

  // Fungsi utama untuk mengambil data renungan
  Future<void> fetchRenungan() async {
    _isLoading = true;
    notifyListeners(); // Kasih tahu UI untuk nampilin animasi loading

    try {
      // 🌟 1. Ambil data objek tunggal untuk halaman depan
      _renunganHariIni = await _repository.getRenunganHariIni();

      // 📂 2. Ambil data list lengkap untuk halaman arsip
      _daftarRenungan = await _repository.getRenungan();
    } catch (e) {
      print("Gagal mengambil data renungan: $e");
    } finally {
      _isLoading = false;
      notifyListeners(); // Kasih tahu UI bahwa data siap ditampilkan!
    }
  }
}