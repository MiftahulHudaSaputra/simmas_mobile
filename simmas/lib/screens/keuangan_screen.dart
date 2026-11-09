import 'package:flutter/material.dart';
import '../models/transaksi.dart';

class KeuanganScreen extends StatefulWidget {
  final Function(String) onNotify;

  const KeuanganScreen({super.key, required this.onNotify});

  @override
  State<KeuanganScreen> createState() => _KeuanganScreenState();
}

class _KeuanganScreenState extends State<KeuanganScreen> {
  String _selectedFilter = 'Semua';

  final List<Transaksi> _list = [
    Transaksi(id: '1', judul: 'Infaq Kotak Jumat', kategori: 'Infaq Jamaah', jumlah: 3450000, tanggal: DateTime.now(), isPemasukan: true),
    Transaksi(id: '2', judul: 'Tagihan Listrik & AC Masjid', kategori: 'Operational', jumlah: 820000, tanggal: DateTime.now(), isPemasukan: false),
    Transaksi(id: '3', judul: 'Donasi Renovasi Tempat Wudhu', kategori: 'Donasi Khusus', jumlah: 5000000, tanggal: DateTime.now(), isPemasukan: true),
  ];

  void _showFormDialog({Transaksi? item}) {
    final isEdit = item != null;
    final judulController = TextEditingController(text: isEdit ? item.judul : '');
    final jumlahController = TextEditingController(text: isEdit ? item.jumlah.toStringAsFixed(0) : '');
    String kategori = isEdit ? item.kategori : 'Infaq Jamaah';
    bool isPemasukan = isEdit ? item.isPemasukan : true;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setModalState) => Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 20,
            right: 20,
            top: 20,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      isEdit ? 'Edit Transaksi Kas' : 'Tambah Transaksi Kas',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(ctx),
                    ),
                  ],
                ),
                const Divider(),
                const SizedBox(height: 8),
                const Text('Jenis Transaksi', style: TextStyle(fontSize: 12, color: Colors.grey)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setModalState(() => isPemasukan = true),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: isPemasukan ? Colors.teal.shade50 : Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isPemasukan ? const Color(0xFF0F766E) : Colors.grey.shade300,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Pemasukan (+)',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: isPemasukan ? const Color(0xFF0F766E) : Colors.grey.shade600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setModalState(() => isPemasukan = false),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: !isPemasukan ? Colors.red.shade50 : Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: !isPemasukan ? Colors.red : Colors.grey.shade300,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Pengeluaran (-)',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: !isPemasukan ? Colors.red : Colors.grey.shade600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text('Judul Transaksi', style: TextStyle(fontSize: 12, color: Colors.grey)),
                const SizedBox(height: 6),
                TextField(
                  controller: judulController,
                  decoration: InputDecoration(
                    hintText: 'Contoh: Infaq Kotak Jumat',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  ),
                ),
                const SizedBox(height: 16),
                const Text('Jumlah (Rp)', style: TextStyle(fontSize: 12, color: Colors.grey)),
                const SizedBox(height: 6),
                TextField(
                  controller: jumlahController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: '0',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  ),
                ),
                const SizedBox(height: 16),
                const Text('Kategori', style: TextStyle(fontSize: 12, color: Colors.grey)),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: kategori,
                      isExpanded: true,
                      items: ['Infaq Jamaah', 'Operational', 'Donasi Khusus', 'Gaji Marbot']
                          .map((val) => DropdownMenuItem(value: val, child: Text(val)))
                          .toList(),
                      onChanged: (val) {
                        if (val != null) setModalState(() => kategori = val);
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0F766E),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                    onPressed: () {
                      if (judulController.text.isEmpty || jumlahController.text.isEmpty) return;
                      setState(() {
                        if (isEdit) {
                          item.judul = judulController.text;
                          item.kategori = kategori;
                          item.jumlah = double.tryParse(jumlahController.text) ?? 0;
                          item.isPemasukan = isPemasukan;
                        } else {
                          _list.insert(
                            0,
                            Transaksi(
                              id: DateTime.now().toString(),
                              judul: judulController.text,
                              kategori: kategori,
                              jumlah: double.tryParse(jumlahController.text) ?? 0,
                              tanggal: DateTime.now(),
                              isPemasukan: isPemasukan,
                            ),
                          );
                        }
                      });
                      Navigator.pop(ctx);
                      widget.onNotify(isEdit ? 'Transaksi berhasil diperbarui' : 'Transaksi berhasil dicatat');
                    },
                    child: const Text('Simpan Transaksi Kas', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _deleteItem(String id) {
    setState(() {
      _list.removeWhere((e) => e.id == id);
    });
    widget.onNotify('Transaksi berhasil dihapus');
  }

  @override
  Widget build(BuildContext context) {
    final filteredList = _list.where((item) {
      if (_selectedFilter == 'Pemasukan') return item.isPemasukan;
      if (_selectedFilter == 'Pengeluaran') return !item.isPemasukan;
      return true;
    }).toList();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              color: const Color(0xFF0F766E),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.mosque, color: Colors.white, size: 28),
                      ),
                      const SizedBox(width: 12),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('SIMMAS', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                          Text('Masjid Al-Ikhlas Utama', style: TextStyle(color: Colors.white70, fontSize: 12)),
                        ],
                      ),
                    ],
                  ),
                  const Icon(Icons.notifications, color: Colors.white),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF0F766E),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Total Balance Kas Masjid', style: TextStyle(color: Colors.white70, fontSize: 13)),
                  const SizedBox(height: 4),
                  const Text('Rp 6.130.000', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Divider(color: Colors.white24, height: 1),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), shape: BoxShape.circle),
                            child: const Icon(Icons.arrow_downward, color: Colors.white, size: 14),
                          ),
                          const SizedBox(width: 8),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Total Masuk', style: TextStyle(color: Colors.white70, fontSize: 10)),
                              Text('Rp 8.450.000', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), shape: BoxShape.circle),
                            child: const Icon(Icons.arrow_upward, color: Colors.white, size: 14),
                          ),
                          const SizedBox(width: 8),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Total Keluar', style: TextStyle(color: Colors.white70, fontSize: 10)),
                              Text('Rp 2.320.000', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: ['Semua', 'Pemasukan', 'Pengeluaran'].map((filter) {
                    final isSelected = _selectedFilter == filter;
                    return Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _selectedFilter = filter),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.white : Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: isSelected ? [BoxShadow(color: Colors.black12, blurRadius: 4, offset: const Offset(0, 2))] : [],
                          ),
                          child: Center(
                            child: Text(
                              filter,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                color: isSelected ? const Color(0xFF0F766E) : Colors.grey.shade600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 14),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('Riwayat Transaksi Kas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: filteredList.length,
                itemBuilder: (context, index) {
                  final tx = filteredList[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: tx.isPemasukan ? Colors.green.shade50 : Colors.red.shade50,
                          child: Icon(
                            tx.isPemasukan ? Icons.arrow_downward : Icons.arrow_upward,
                            color: tx.isPemasukan ? Colors.green : Colors.red,
                            size: 18,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(tx.judul, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                              const SizedBox(height: 2),
                              Text('${tx.kategori} • ${tx.tanggal.day} Nov 2026', style: TextStyle(color: Colors.grey.shade600, fontSize: 11)),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '${tx.isPemasukan ? "+" : "-"} Rp ${tx.jumlah.toStringAsFixed(0)}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                color: tx.isPemasukan ? Colors.green.shade700 : Colors.red.shade700,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                InkWell(
                                  onTap: () => _showFormDialog(item: tx),
                                  child: Icon(Icons.edit, size: 16, color: Colors.grey.shade600),
                                ),
                                const SizedBox(width: 12),
                                InkWell(
                                  onTap: () => _deleteItem(tx.id),
                                  child: const Icon(Icons.delete, size: 16, color: Colors.red),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showFormDialog(),
        backgroundColor: const Color(0xFF0F766E),
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Catat Transaksi'),
      ),
    );
  }
}