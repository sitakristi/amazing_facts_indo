part of viewmodels;

class KontakViewModel extends ChangeNotifier {
  final KontakRepository _repository = KontakRepository();

  // Karena data kontak hanya 1 objek (bukan daftar/list), kita gunakan data tunggal yang bisa kosong di awal
  KontakModel? _kontakInfo;
  bool _isLoading = false;

  KontakModel? get kontakInfo => _kontakInfo;
  bool get isLoading => _isLoading;

  Future<void> fetchKontakInfo() async {
    _isLoading = true;
    notifyListeners();

    try {
      _kontakInfo = await _repository.getKontakInfo();
    } catch (e) {
      print("Gagal mengambil data kontak: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}