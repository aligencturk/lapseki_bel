import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/constants/app_colors.dart';
import '../../widgets/language_switcher.dart';

class ProjelerScreen extends StatelessWidget {
  const ProjelerScreen({super.key});

  Future<void> _openLink(BuildContext context, String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Link açılamadı')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Projeler',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.primaryBlue,

        actions: [const LanguageSwitcher(), const SizedBox(width: 8)],
      ),
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            const TabBar(
              labelColor: AppColors.primaryBlue,
              indicatorColor: AppColors.primaryBlue,
              tabs: [
                Tab(text: 'Devam Edenler'),
                Tab(text: 'Tamamlananlar'),
                Tab(text: 'Planlanan'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _buildProjectList('Devam Eden Projeler'),
                  _buildProjectList('Tamamlanan Projeler'),
                  _buildProjectList('Planlanan Projeler'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProjectList(String title) {
    return Builder(
      builder: (context) => ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: ListTile(
              leading: const Icon(
                Icons.construction,
                size: 40,
                color: AppColors.primaryBlue,
              ),
              title: const Text(
                'Proje Başlığı',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: const Text('Proje açıklaması burada yer alacak.'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // TODO: Proje detay sayfası
              },
            ),
          ),
          Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: ListTile(
              leading: const Icon(
                Icons.park,
                size: 40,
                color: AppColors.accentGreen,
              ),
              title: const Text(
                'Kent Parkı',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: const Text('Şehir merkezi park projesi.'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            ),
          ),
          Center(
            child: TextButton.icon(
              onPressed: () {
                _openLink(
                  context,
                  'https://lapseki.bel.tr/projeler/devam-edenler',
                );
              },
              icon: const Icon(Icons.open_in_browser),
              label: const Text('Tüm Projeleri Gör'),
            ),
          ),
        ],
      ),
    );
  }
}
