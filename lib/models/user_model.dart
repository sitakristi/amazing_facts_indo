part of models;

class UserModel extends Equatable {
  final String id;
  final String namaLengkap;
  final String email;
  final String kataSandi;
  final String tanggalLahir;
  final String nomorTelepon;
  final String alamat;

  const UserModel({
    required this.id,
    required this.namaLengkap,
    required this.email,
    required this.kataSandi,
    this.tanggalLahir = "01-01-2000",
    this.nomorTelepon = "-",
    this.alamat = "-",
  });

  @override
  List<Object?> get props => [id, namaLengkap, email, kataSandi, tanggalLahir, nomorTelepon, alamat];
}