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
    Agenda(
      id: '1',
      judul: 'Kajian Subuh Minggu',
      penceramah: 'Ust. Dr. H. Ahmad Wijaya',
      tanggal: DateTime.now(),
      waktu: '05:00 WIB',
      lokasi: 'Ruang Utama Masjid',
    ),
    Agenda(
      id: '2',
      judul: 'Gotong Royong Kebersihan',
      penceramah: 'Persiapan Acara Isra Mi\'raj',
      tanggal: DateTime.now(),
      waktu: '07:30 WIB',
      lokasi: 'Halaman Masjid',
    ),
    Agenda(
      id: '3',
      judul: 'Pelatihan Pengurusan Jenazah',
      penceramah: 'Tim Pemulasaran DKM',
      tanggal: DateTime.now(),
      waktu: '09:00 WIB',
      lokasi: 'Aula Masjid',
    ),
  ];

  InputDecoration _agendaInputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Color(0xFF9CA3AF)),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      border: OutlineInputBorder(
        borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
        borderRadius: BorderRadius.circular(14),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
        borderRadius: BorderRadius.circular(14),
      ),
    );
  }

  void _showFormDialog({Agenda? item}) {
    final isEdit = item != null;
    final judulController = TextEditingController(
      text: isEdit ? item.judul : '',
    );
    final penceramahController = TextEditingController(
      text: isEdit ? item.penceramah : '',
    );
    final waktuController = TextEditingController(
      text: isEdit ? item.waktu : '',
    );
    final lokasiController = TextEditingController(
      text: isEdit ? item.lokasi : '',
    );
    final tanggalController = TextEditingController(
      text: isEdit
          ? '${item.tanggal.day.toString().padLeft(2, '0')} Nov 2026'
          : '08 Nov 2026',
    );

    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        insetPadding: const EdgeInsets.fromLTRB(6, 24, 6, 10),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 18),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      isEdit
                          ? 'Edit Agenda Kegiatan'
                          : 'Tambah Agenda Kegiatan',
                      style: const TextStyle(
                        color: Color(0xFF111827),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(ctx),
                    icon: const Icon(
                      Icons.close_rounded,
                      color: Color(0xFF9CA3AF),
                    ),
                  ),
                ],
              ),
              const Divider(height: 24, color: Color(0xFFE5E7EB)),
              const Text(
                'Nama Agenda / Kegiatan',
                style: TextStyle(
                  color: Color(0xFF374151),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: judulController,
                decoration: _agendaInputDecoration('Contoh: Kajian Subuh Ahad'),
              ),
              const SizedBox(height: 14),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Tanggal',
                          style: TextStyle(
                            color: Color(0xFF374151),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: tanggalController,
                          decoration: _agendaInputDecoration('08 Nov 2026'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Waktu',
                          style: TextStyle(
                            color: Color(0xFF374151),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: waktuController,
                          decoration: _agendaInputDecoration('05:00 WIB'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              const Text(
                'Pemateri / PJ / Deskripsi',
                style: TextStyle(
                  color: Color(0xFF374151),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: penceramahController,
                decoration: _agendaInputDecoration(
                  'Pemateri / Penanggung Jawab',
                ),
              ),
              const SizedBox(height: 14),
              const Text(
                'Lokasi',
                style: TextStyle(
                  color: Color(0xFF374151),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: lokasiController,
                decoration: _agendaInputDecoration('Ruang Utama Masjid'),
              ),
              const SizedBox(height: 18),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFF079669),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
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
                    widget.onNotify(
                      isEdit
                          ? 'Agenda berhasil diperbarui'
                          : 'Agenda baru ditambahkan',
                    );
                  },
                  child: const Text(
                    'Simpan Agenda Kegiatan',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
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
            // Header SIMMAS[cite: 5]
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
                        child: const Icon(
                          Icons.mosque,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'SIMMAS',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Masjid Al-Ikhlas Utama',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Icon(Icons.notifications, color: Colors.white),
                ],
              ),
            ),

            // Judul Halaman Agenda & Badge[cite: 5]
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Manajemen Agenda & Kegiatan',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Jadwal pengajian, gotong royong & kegiatan masjid',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.teal.shade50,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${_list.length}',
                      style: const TextStyle(
                        color: Color(0xFF0F766E),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Daftar Agenda[cite: 5]
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
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.teal.shade50,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Column(
                                children: [
                                  Text(
                                    '08',
                                    style: TextStyle(
                                      color: Color(0xFF0F766E),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    'NOV',
                                    style: TextStyle(
                                      color: Color(0xFF0F766E),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 9,
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
                                  Text(
                                    a.judul,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    a.penceramah,
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                InkWell(
                                  onTap: () => _showFormDialog(item: a),
                                  child: Icon(
                                    Icons.edit,
                                    size: 18,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                InkWell(
                                  onTap: () => _deleteItem(a.id),
                                  child: const Icon(
                                    Icons.delete,
                                    size: 18,
                                    color: Colors.red,
                                  ),
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
                                const Icon(
                                  Icons.access_time,
                                  size: 13,
                                  color: Colors.grey,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  a.waktu,
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on,
                                  size: 13,
                                  color: Colors.grey,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  a.lokasi,
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: Colors.grey,
                                  ),
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
        label: const Text('Tambah Agenda'),
      ),
    );
  }
}
