class TransaksiZakat {
  String id;
  String nama;
  String jenisZakat;
  double jumlahUang;
  double jumlahBeras;
  DateTime tanggal;
  bool isPenerimaan; // true = Terima Zakat, false = Penyaluran Zakat

  TransaksiZakat({
    required this.id,
    required this.nama,
    required this.jenisZakat,
    required this.jumlahUang,
    required this.jumlahBeras,
    required this.tanggal,
    required this.isPenerimaan,
  });
}