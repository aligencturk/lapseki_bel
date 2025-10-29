import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/logger_util.dart';
import '../../../data/models/pharmacy.dart';
import '../../../data/services/pharmacy_service.dart';

class NobetciEczaneScreen extends StatefulWidget {
  const NobetciEczaneScreen({super.key});

  @override
  State<NobetciEczaneScreen> createState() => _NobetciEczaneScreenState();
}

class _NobetciEczaneScreenState extends State<NobetciEczaneScreen> {
  final PharmacyService _service = PharmacyService();
  late Future<List<Pharmacy>> _future;

  @override
  void initState() {
    super.initState();
    _future = _service.fetchDutyPharmacies(forceMock: true);
  }

  Future<void> _refresh() async {
    AppLogger.debug('Nöbetçi eczaneler yenileniyor');
    setState(() {
      _future = _service.fetchDutyPharmacies(forceMock: false);
    });
    await _future;
  }

  Future<void> _call(String? phone) async {
    if (phone == null) return;
    final uri = Uri.parse('tel:$phone');
    try {
      final ok = await canLaunchUrl(uri);
      if (ok) await launchUrl(uri);
    } catch (e, st) {
      AppLogger.error('Telefon araması başlatılamadı', e, st);
    }
  }

  Future<void> _openMaps(String? address, String name) async {
    final query = Uri.encodeComponent('${address ?? ''} $name Lapseki');
    final uri = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=$query',
    );
    try {
      final ok = await canLaunchUrl(uri);
      if (ok) await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e, st) {
      AppLogger.error('Harita açılamadı', e, st);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Nöbetçi Eczaneler',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.primaryBlue,
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: FutureBuilder<List<Pharmacy>>(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return _ErrorView(onRetry: _refresh);
            }

            final data = snapshot.data ?? const <Pharmacy>[];
            if (data.isEmpty) {
              return _EmptyView(onRetry: _refresh);
            }

            return ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(12),
              itemCount: data.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final p = data[index];
                return Card(
                  elevation: 0,
                  color: const Color(0xFFFAFAFA),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              'assets/images/nobetci-eczane.png',
                              width: 28,
                              height: 28,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(
                                    Icons.local_pharmacy,
                                    color: AppColors.primaryBlue,
                                  ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    p.name,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                  if (p.address != null &&
                                      p.address!.isNotEmpty)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 4),
                                      child: Text(
                                        p.address!,
                                        style: const TextStyle(
                                          color: AppColors.textSecondary,
                                        ),
                                      ),
                                    ),
                                  if (p.phone != null)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 4),
                                      child: Text(
                                        p.phone!,
                                        style: const TextStyle(
                                          color: AppColors.textSecondary,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            ElevatedButton.icon(
                              onPressed: p.phone == null
                                  ? null
                                  : () => _call(p.phone),
                              icon: const Icon(Icons.call),
                              label: const Text('Ara'),
                            ),
                            const SizedBox(width: 8),
                            OutlinedButton.icon(
                              onPressed: () => _openMaps(p.address, p.name),
                              icon: const Icon(Icons.map),
                              label: const Text('Haritada Aç'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class _EmptyView extends StatelessWidget {
  final Future<void> Function() onRetry;
  const _EmptyView({required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        const SizedBox(height: 120),
        const Icon(
          Icons.info_outline,
          size: 48,
          color: AppColors.textSecondary,
        ),
        const SizedBox(height: 8),
        const Center(child: Text('Kayıt bulunamadı')),
        const SizedBox(height: 8),
        Center(
          child: TextButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh),
            label: const Text('Yenile'),
          ),
        ),
      ],
    );
  }
}

class _ErrorView extends StatelessWidget {
  final Future<void> Function() onRetry;
  const _ErrorView({required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        const SizedBox(height: 120),
        const Icon(Icons.error_outline, size: 48, color: AppColors.error),
        const SizedBox(height: 8),
        const Center(child: Text('Veri alınamadı')),
        const SizedBox(height: 8),
        Center(
          child: TextButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh),
            label: const Text('Tekrar Dene'),
          ),
        ),
      ],
    );
  }
}
