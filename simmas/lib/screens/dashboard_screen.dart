import 'dart:async';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  final VoidCallback onToggleTheme;
  final bool isDarkMode;

  const DashboardScreen({
    super.key,
    required this.onToggleTheme,
    required this.isDarkMode,
  });

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late String _currentTimeString;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _currentTimeString = _formatCurrentTime();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          _currentTimeString = _formatCurrentTime();
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _formatCurrentTime() {
    final now = DateTime.now();
    return "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                            Text(
                              'SIMMAS',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                              ),
                            ),
                            Text(
                              'Masjid Al-Ikhlas Utama',
                              style: TextStyle(color: Colors.white70, fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Stack(
                      children: [
                        IconButton(
                          icon: Icon(
                            widget.isDarkMode ? Icons.light_mode : Icons.notifications,
                            color: Colors.white,
                          ),
                          onPressed: widget.onToggleTheme,
                          tooltip: 'Ganti Mode Terang/Gelap',
                        ),
                        Positioned(
                          right: 12,
                          top: 12,
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: Colors.amber,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ],
                    ),
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
                    const Text(
                      "Assalamu'alaikum Pengurus,",
                      style: TextStyle(color: Colors.white70, fontSize: 13),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      "Selamat Datang di SIMMAS",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        const Icon(Icons.calendar_today, color: Colors.white70, size: 14),
                        const SizedBox(width: 6),
                        const Text(
                          'Sabtu, 7 November 2026',
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.black26,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            _currentTimeString,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Ringkasan Utama',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Update Realtime',
                      style: TextStyle(fontSize: 12, color: Colors.teal.shade700, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: Colors.grey.shade200),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Saldo Kas', style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
                                Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: Colors.green.shade50,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Icon(Icons.account_balance_wallet, color: Colors.green, size: 18),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              'Rp 6.130.000',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              '↑ Kas Siap Pakai',
                              style: TextStyle(color: Colors.green, fontSize: 11, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: Colors.grey.shade200),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Zakat Tersedia', style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
                                Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: Colors.teal.shade50,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Icon(Icons.volunteer_activism, color: Colors.teal, size: 18),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              'Rp 3.720.000',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              '+ 5.0 Kg Beras',
                              style: TextStyle(color: Colors.teal, fontSize: 11, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.access_time, color: Colors.teal.shade700, size: 20),
                              const SizedBox(width: 8),
                              const Text('Jadwal Shalat Hari Ini', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.green.shade50,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Text('DKI Jakarta', style: TextStyle(color: Colors.green, fontSize: 10, fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const [
                          _JadwalCard(waktu: '04:26', nama: 'Subuh'),
                          _JadwalCard(waktu: '11:54', nama: 'Dzuhur'),
                          _JadwalCard(waktu: '15:12', nama: 'Ashar', isActive: true),
                          _JadwalCard(waktu: '18:02', nama: 'Maghrib'),
                          _JadwalCard(waktu: '19:14', nama: 'Isya'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Agenda Terdekat', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    Text('Lihat Semua >', style: TextStyle(fontSize: 12, color: Colors.teal.shade700, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.teal.shade50,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Column(
                          children: [
                            Text('08', style: TextStyle(color: Color(0xFF0F766E), fontWeight: FontWeight.bold, fontSize: 16)),
                            Text('NOV', style: TextStyle(color: Color(0xFF0F766E), fontWeight: FontWeight.bold, fontSize: 10)),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Kajian Subuh Minggu', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                            const SizedBox(height: 2),
                            Text('Ust. Dr. H. Ahmad Wijaya', style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                const Icon(Icons.access_time, size: 12, color: Colors.grey),
                                const SizedBox(width: 4),
                                const Text('05:00 WIB', style: TextStyle(fontSize: 11, color: Colors.grey)),
                                const SizedBox(width: 12),
                                const Icon(Icons.location_on, size: 12, color: Colors.grey),
                                const SizedBox(width: 4),
                                const Text('Ruang Utama Masjid', style: TextStyle(fontSize: 11, color: Colors.grey)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

class _JadwalCard extends StatelessWidget {
  final String waktu;
  final String nama;
  final bool isActive;

  const _JadwalCard({required this.waktu, required this.nama, this.isActive = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF0F766E) : Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: isActive ? null : Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          Text(
            nama,
            style: TextStyle(
              fontSize: 11,
              color: isActive ? Colors.white70 : Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            waktu,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: isActive ? Colors.white : Colors.black87,
            ),
          ),
          if (isActive) ...[
            const SizedBox(height: 4),
            const Text(
              'Berikutnya',
              style: TextStyle(fontSize: 8, color: Colors.white, fontWeight: FontWeight.w500),
            ),
          ]
        ],
      ),
    );
  }
}