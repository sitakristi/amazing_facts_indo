class UserModel {
  String id;
  String namaLengkap;
  String email;
  String kataSandi;
  String tanggalLahir;
  String nomorTelepon;
  String alamat;

  UserModel({
    required this.id,
    required this.namaLengkap,
    required this.email,
    required this.kataSandi,
    this.tanggalLahir = "01-01-2000",
    this.nomorTelepon = "-",
    this.alamat = "-",
  });
}