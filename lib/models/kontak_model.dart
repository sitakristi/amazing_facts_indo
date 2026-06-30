// lib/models/kontak_model.dart
part of models;

class KontakModel extends Equatable {
  final String nomorHotline;
  final String nomorHumas;
  final String namaBank;
  final String nomorRekening;
  final String atasNama;

  const KontakModel({
    required this.nomorHotline,
    required this.nomorHumas,
    required this.namaBank,
    required this.nomorRekening,
    required this.atasNama,
  });

  @override
  List<Object?> get props => [nomorHotline, nomorHumas, namaBank, nomorRekening, atasNama];

  factory KontakModel.fromJson(Map<String, dynamic> json) {
    return KontakModel(
      nomorHotline: json['cs_whatsapp'] ?? '',       // Cocokkan dengan database Laravel
      nomorHumas: json['donation_whatsapp'] ?? '',   // Cocokkan dengan database Laravel
      namaBank: json['nama_bank'] ?? 'Bank Central Asia', // Beri default nama bank kamu
      nomorRekening: json['bca_account'] ?? '',      // Cocokkan dengan database Laravel
      atasNama: json['bca_name'] ?? '',              // Cocokkan dengan database Laravel
    );
  }
}