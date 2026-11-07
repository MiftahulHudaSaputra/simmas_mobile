class Transaksi {
  String id;
  String judul;
  String kategori;
  double jumlah;
  DateTime tanggal;
  bool isPemasukan;

  Transaksi({
    required this.id,
    required this.judul,
    required this.kategori,
    required this.jumlah,
    required this.tanggal,
    required this.isPemasukan,
  });
}