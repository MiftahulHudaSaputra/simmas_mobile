import 'package:flutter/material.dart';
import '../models/zakat.dart';

class ZakatScreen extends StatefulWidget {
  final Function(String) onNotify;

  const ZakatScreen({super.key, required this.onNotify});

  @override
  State<ZakatScreen> createState() => _ZakatScreenState();
}

class _ZakatScreenState extends State<ZakatScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<TransaksiZakat> _list = [
    TransaksiZakat(id: '1', nama: 'H. Abdullah & Keluarga', jenisZakat: 'Zakat Fitrah', jumlahUang: 220000, jumlahBeras: 0, tanggal: DateTime.now(), isPenerimaan: true),
    TransaksiZakat(id: '2', nama: 'Ibu Hj. Aminah', jenisZakat: 'Zakat Maal', jumlahUang: 4500000, jumlahBeras: 0, tanggal: DateTime.now(), isPenerimaan: true),
    TransaksiZakat(id: '3', nama: 'Bpk. Ahmad Subagyo', jenisZakat: 'Zakat Fitrah', jumlahUang: 0, jumlahBeras: 10, tanggal: DateTime.now(), isPenerimaan: true),
    TransaksiZakat(id: '4', nama: 'Warga Dhuafa RT 01', jenisZakat: 'Penyaluran Fitrah', jumlahUang: 500000, jumlahBeras: 5, tanggal: DateTime.now(), isPenerimaan: false),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  void _showFormDialog({TransaksiZakat? item}) {
    final isEdit = item != null;
    final isPenerimaan = isEdit ? item.isPenerimaan : (_tabController.index == 0);

    final namaController = TextEditingController(text: isEdit ? item.nama : '');
    String jenisZakat = isEdit ? item.jenisZakat : 'Zakat Fitrah';
    bool isBentukUang = isEdit ? (item.jumlahUang > 0) : true;
    final nominalController = TextEditingController(
      text: isEdit ? (isBentukUang ? item.jumlahUang.toStringAsFixed(0) : item.jumlahBeras.toString()) : '0',
    );

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
                      isEdit
                          ? (isPenerimaan ? 'Edit Terima Zakat' : 'Edit Penyaluran Zakat')
                          : (isPenerimaan ? 'Terima Zakat (Muzakki)' : 'Penyaluran Zakat (Mustahik)'),
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
                Text(isPenerimaan ? 'Nama Muzakki (Pembayar)' : 'Nama Mustahik (Penerima)',
                    style: const TextStyle(fontSize: 12, color: Colors.grey)),
                const SizedBox(height: 6),
                TextField(
                  controller: namaController,
                  decoration: InputDecoration(
                    hintText: 'Nama Lengkap',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  ),
                ),
                const SizedBox(height: 16),
                const Text('Jenis Zakat / Golongan Mustahik', style: TextStyle(fontSize: 12, color: Colors.grey)),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: jenisZakat,
                      isExpanded: true,
                      items: ['Zakat Fitrah', 'Zakat Maal', 'Fakir Miskin', 'Fisabilillah']
                          .map((val) => DropdownMenuItem(value: val, child: Text(val)))
                          .toList(),
                      onChanged: (val) {
                        if (val != null) setModalState(() => jenisZakat = val);
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text('Bentuk Zakat / Bantuan', style: TextStyle(fontSize: 12, color: Colors.grey)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setModalState(() => isBentukUang = true),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: isBentukUang ? Colors.teal.shade50 : Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isBentukUang ? const Color(0xFF0F766E) : Colors.grey.shade300,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Uang (Rp)',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: isBentukUang ? const Color(0xFF0F766E) : Colors.grey.shade600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setModalState(() => isBentukUang = false),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: !isBentukUang ? Colors.teal.shade50 : Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: !isBentukUang ? const Color(0xFF0F766E) : Colors.grey.shade300,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Beras (Kg)',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: !isBentukUang ? const Color(0xFF0F766E) : Colors.grey.shade600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(isBentukUang ? 'Nominal Uang (Rp)' : 'Jumlah Beras (Kg)',
                    style: const TextStyle(fontSize: 12, color: Colors.grey)),
                const SizedBox(height: 6),
                TextField(
                  controller: nominalController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
                      if (namaController.text.isEmpty) return;
                      final valNum = double.tryParse(nominalController.text) ?? 0;
                      setState(() {
                        if (isEdit) {
                          item.nama = namaController.text;
                          item.jenisZakat = jenisZakat;
                          item.jumlahUang = isBentukUang ? valNum : 0;
                          item.jumlahBeras = !isBentukUang ? valNum : 0;
                        } else {
                          _list.insert(
                            0,
                            TransaksiZakat(
                              id: DateTime.now().toString(),
                              nama: namaController.text,
                              jenisZakat: jenisZakat,
                              jumlahUang: isBentukUang ? valNum : 0,
                              jumlahBeras: !isBentukUang ? valNum : 0,
                              tanggal: DateTime.now(),
                              isPenerimaan: isPenerimaan,
                            ),
                          );
                        }
                      });
                      Navigator.pop(ctx);
                      widget.onNotify(isEdit ? 'Data zakat diperbarui' : 'Data zakat berhasil disimpan');
                    },
                    child: const Text('Simpan Data Zakat', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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
    widget.onNotify('Data zakat berhasil dihapus');
  }

  @override
  Widget build(BuildContext context) {
    final terimaList = _list.where((e) => e.isPenerimaan).toList();
    final salurList = _list.where((e) => !e.isPenerimaan).toList();

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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Saldo Zakat Siap Disalurkan', style: TextStyle(color: Colors.white70, fontSize: 13)),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text('Baitul Maal', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  const Text('Rp 3.720.000', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Divider(color: Colors.white24, height: 1),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Stok Beras Zakat:', style: TextStyle(color: Colors.white70, fontSize: 13)),
                      const Text('5.0 Kg', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey.shade300, width: 1)),
              ),
              child: TabBar(
                controller: _tabController,
                labelColor: const Color(0xFF0F766E),
                unselectedLabelColor: Colors.grey,
                indicatorColor: const Color(0xFF0F766E),
                indicatorWeight: 3,
                tabs: const [
                  Tab(text: 'Terima Zakat (Muzakki)'),
                  Tab(text: 'Penyaluran (Mustahik)'),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildZakatListView(terimaList),
                  _buildZakatListView(salurList),
                ],
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
        label: Text(_tabController.index == 0 ? 'Terima Zakat' : 'Salurkan Zakat'),
      ),
    );
  }

  Widget _buildZakatListView(List<TransaksiZakat> list) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: list.length,
      itemBuilder: (context, index) {
        final z = list[index];
        final isUang = z.jumlahUang > 0;
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
                backgroundColor: Colors.teal.shade50,
                child: const Icon(Icons.person, color: Color(0xFF0F766E), size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(z.nama, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                    const SizedBox(height: 2),
                    Text('${z.jenisZakat} • 06 Nov 2026', style: TextStyle(color: Colors.grey.shade600, fontSize: 11)),
                    const SizedBox(height: 4),
                    const Text('Diterima', style: TextStyle(color: Colors.teal, fontSize: 10, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    isUang ? 'Rp ${z.jumlahUang.toStringAsFixed(0)}' : '${z.jumlahBeras} Kg Beras',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF0F766E)),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                        onTap: () => _showFormDialog(item: z),
                        child: Icon(Icons.edit, size: 16, color: Colors.grey.shade600),
                      ),
                      const SizedBox(width: 12),
                      InkWell(
                        onTap: () => _deleteItem(z.id),
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
    );
  }
}