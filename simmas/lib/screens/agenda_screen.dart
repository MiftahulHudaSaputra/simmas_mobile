import 'package:flutter/material.dart';
import '../models/agenda.dart';

class AgendaScreen extends StatefulWidget {
  final Function(String) onNotify;

  const AgendaScreen({super.key, required this.onNotify});

  @override
  State<AgendaScreen> createState() => _AgendaScreenState();
}

class _AgendaScreenState extends State<AgendaScreen> {
  final List<Agenda> _list = [
    Agenda(id: '1', judul: 'Kajian Subuh Minggu', penceramah: 'Ust. Dr. H. Ahmad Wijaya', tanggal: DateTime.now(), waktu: '05:00 WIB', lokasi: 'Ruang Utama Masjid'),
    Agenda(id: '2', judul: 'Gotong Royong Kebersihan', penceramah: 'Persiapan Acara Isra Mi\'raj', tanggal: DateTime.now(), waktu: '07:30 WIB', lokasi: 'Halaman Masjid'),
    Agenda(id: '3', judul: 'Pelatihan Pengurusan Jenazah', penceramah: 'Tim Pemulasaran DKM', tanggal: DateTime.now(), waktu: '09:00 WIB', lokasi: 'Aula Masjid'),
  ];

  void _showFormDialog({Agenda? item}) {
    final isEdit = item != null;
    final judulController = TextEditingController(text: isEdit ? item.judul : '');
    final penceramahController = TextEditingController(text: isEdit ? item.penceramah : '');
    final waktuController = TextEditingController(text: isEdit ? item.waktu : '05:00 WIB');
    final lokasiController = TextEditingController(text: isEdit ? item.lokasi : 'Ruang Utama Masjid');

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
                      isEdit ? 'Edit Agenda Kegiatan' : 'Tambah Agenda Kegiatan',
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
                const Text('Nama Agenda / Kegiatan', style: TextStyle(fontSize: 12, color: Colors.grey)),
                const SizedBox(height: 6),
                TextField(
                  controller: judulController,
                  decoration: InputDecoration(
                    hintText: 'Contoh: Kajian Subuh Ahad',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Tanggal', style: TextStyle(fontSize: 12, color: Colors.grey)),
                          const SizedBox(height: 6),
                          TextField(
                            readOnly: true,
                            controller: TextEditingController(text: '08 Nov 2026'),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Waktu', style: TextStyle(fontSize: 12, color: Colors.grey)),
                          const SizedBox(height: 6),
                          TextField(
                            controller: waktuController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text('Pemateri / PJ / Deskripsi', style: TextStyle(fontSize: 12, color: Colors.grey)),
                const SizedBox(height: 6),
                TextField(
                  controller: penceramahController,
                  decoration: InputDecoration(
                    hintText: 'Pemateri / Penanggung Jawab',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  ),
                ),
                const SizedBox(height: 16),
                const Text('Lokasi', style: TextStyle(fontSize: 12, color: Colors.grey)),
                const SizedBox(height: 6),
                TextField(
                  controller: lokasiController,
                  decoration: InputDecoration(
                    hintText: 'Ruang Utama Masjid',
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
                      if (judulController.text.isEmpty) return;
                      setState(() {
                        if (isEdit) {
                          item.judul = judulController.text;
                          item.penceramah = penceramahController.text;
                          item.waktu = waktuController.text;
                          item.lokasi = lokasiController.text;
                        } else {
                          _list.insert(
                            0,
                            Agenda(
                              id: DateTime.now().toString(),
                              judul: judulController.text,
                              penceramah: penceramahController.text,
                              tanggal: DateTime.now(),
                              waktu: waktuController.text,
                              lokasi: lokasiController.text,
                            ),
                          );
                        }
                      });
                      Navigator.pop(ctx);
                      widget.onNotify(isEdit ? 'Agenda berhasil diperbarui' : 'Agenda baru ditambahkan');
                    },
                    child: const Text('Simpan Agenda Kegiatan', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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
    widget.onNotify('Agenda berhasil dihapus');
  }

  @override
  Widget build(BuildContext context) {
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
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Manajemen Agenda & Kegiatan', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      const SizedBox(height: 2),
                      Text('Jadwal pengajian, gotong royong & kegiatan masjid', style: TextStyle(color: Colors.grey.shade600, fontSize: 11)),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.teal.shade50,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text('${_list.length}', style: const TextStyle(color: Color(0xFF0F766E), fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _list.length,
                itemBuilder: (context, index) {
                  final a = _list[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                              decoration: BoxDecoration(
                                color: Colors.teal.shade50,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Column(
                                children: [
                                  Text('08', style: TextStyle(color: Color(0xFF0F766E), fontWeight: FontWeight.bold, fontSize: 14)),
                                  Text('NOV', style: TextStyle(color: Color(0xFF0F766E), fontWeight: FontWeight.bold, fontSize: 9)),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(a.judul, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                                  const SizedBox(height: 2),
                                  Text(a.penceramah, style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                InkWell(
                                  onTap: () => _showFormDialog(item: a),
                                  child: Icon(Icons.edit, size: 18, color: Colors.grey.shade600),
                                ),
                                const SizedBox(width: 12),
                                InkWell(
                                  onTap: () => _deleteItem(a.id),
                                  child: const Icon(Icons.delete, size: 18, color: Colors.red),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Divider(height: 1),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.access_time, size: 13, color: Colors.grey),
                                const SizedBox(width: 4),
                                Text(a.waktu, style: const TextStyle(fontSize: 11, color: Colors.grey)),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(Icons.location_on, size: 13, color: Colors.grey),
                                const SizedBox(width: 4),
                                Text(a.lokasi, style: const TextStyle(fontSize: 11, color: Colors.grey)),
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
        label: const Text('Tambah Agenda'),
      ),
    );
  }
}