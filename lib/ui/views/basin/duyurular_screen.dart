import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_images.dart';
import '../../../core/utils/logger_util.dart';
import '../../../data/models/announcement.dart';
import '../../../data/services/website_scraper_service.dart';
import '../../widgets/announcement_card.dart';

class DuyurularScreen extends StatefulWidget {
  const DuyurularScreen({super.key});

  @override
  State<DuyurularScreen> createState() => _DuyurularScreenState();
}

class _DuyurularScreenState extends State<DuyurularScreen> {
  final WebsiteScraperService _service = WebsiteScraperService();
  late Future<List<Announcement>> _future;

  @override
  void initState() {
    super.initState();
    _future = _service.fetchAnnouncements(limit: 50);
  }

  Future<void> _openLink(String? url) async {
    if (url == null || url.isEmpty) return;
    try {
      final uri = Uri.parse(
        url.startsWith('http') ? url : 'https://lapseki.bel.tr$url',
      );
      final ok = await canLaunchUrl(uri);
      if (ok) await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e, st) {
      AppLogger.error('Duyuru linki açılamadı', e, st);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tüm Duyurular',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.primaryBlue,
      ),
      body: FutureBuilder<List<Announcement>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 48,
                    color: AppColors.error,
                  ),
                  const SizedBox(height: 8),
                  const Text('Duyurular alınamadı'),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () => setState(() {
                      _future = _service.fetchAnnouncements(limit: 50);
                    }),
                    child: const Text('Tekrar Dene'),
                  ),
                ],
              ),
            );
          }
          final items = snapshot.data ?? const <Announcement>[];
          if (items.isEmpty) {
            return const Center(child: Text('Duyuru bulunamadı'));
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: items.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final a = items[index];
              return AnnouncementCard(
                title: a.title,
                date: a.date,
                imageAsset: AppImages.logo,
                onTap: () => _openLink(a.url),
              );
            },
          );
        },
      ),
    );
  }
}
