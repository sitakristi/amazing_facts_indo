class KontakModel {
  final String nomorHotline;
  final String nomorHumas;
  final String namaBank;
  final String nomorRekening;
  final String atasNama;

  KontakModel({
    required this.nomorHotline,
    required this.nomorHumas,
    required this.namaBank,
    required this.nomorRekening,
    required this.atasNama,
  });

  factory KontakModel.fromJson(Map<String, dynamic> json) {
    return KontakModel(
      nomorHotline: json['nomor_hotline'],
      nomorHumas: json['nomor_humas'],
      namaBank: json['nama_bank'],
      nomorRekening: json['nomor_rekening'],
      atasNama: json['atas_nama'],
    );
  }
}