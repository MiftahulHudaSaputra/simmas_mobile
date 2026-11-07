class TransaksiZakat {
  String id;
  String nama; // Nama Muzakki atau Mustahik
  String jenisZakat; // Zakat Fitrah, Zakat Maal, Infaq, dll.
  double jumlahUang;
  double jumlahBeras; // dalam Kg
  DateTime tanggal;
  bool isPenerimaan; // true = Terima dari Muzakki, false = Penyaluran ke Mustahik

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