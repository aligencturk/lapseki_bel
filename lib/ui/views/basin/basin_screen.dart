import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/constants/app_colors.dart';
import '../../widgets/language_switcher.dart';

class BasinScreen extends StatelessWidget {
  const BasinScreen({super.key});

  Future<void> _openLink(BuildContext context, String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Basın',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.accentRed,

        actions: [const LanguageSwitcher(), const SizedBox(width: 8)],
      ),
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            const TabBar(
              labelColor: AppColors.accentRed,
              indicatorColor: AppColors.accentRed,
              tabs: [
                Tab(text: 'Fotoğraf Galeri'),
                Tab(text: 'Video Galeri'),
                Tab(text: 'Basında Lapseki'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _buildGallery(),
                  _buildVideoGallery(),
                  _buildPressNews(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGallery() {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemBuilder: (context, index) {
        return Card(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              color: AppColors.primaryBlue.withValues(alpha: 0.1),
              child: const Icon(
                Icons.photo,
                size: 60,
                color: AppColors.primaryBlue,
              ),
            ),
          ),
        );
      },
      itemCount: 6,
    );
  }

  Widget _buildVideoGallery() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          margin: const EdgeInsets.only(bottom: 16),

          child: ListTile(
            leading: const Icon(
              Icons.play_circle_outline,
              size: 40,
              color: AppColors.accentRed,
            ),
            title: const Text(
              'Video Başlığı',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: const Text('Video açıklaması'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          ),
        ),
      ],
    );
  }

  Widget _buildPressNews() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          margin: const EdgeInsets.only(bottom: 16),

          child: ListTile(
            leading: const Icon(
              Icons.article,
              size: 40,
              color: AppColors.primaryBlue,
            ),
            title: const Text(
              'Haber Başlığı',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: const Text('Basında Lapseki haberleri'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          ),
        ),
      ],
    );
  }
}
