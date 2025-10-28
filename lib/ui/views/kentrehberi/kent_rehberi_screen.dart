import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:logger/logger.dart';
import '../../../core/constants/app_colors.dart';
import '../../widgets/language_switcher.dart';
import '../kurumsal/tarihce_screen.dart';

class KentRehberiScreen extends StatelessWidget {
  const KentRehberiScreen({super.key});

  static final Logger _logger = Logger();

  Future<void> _launchURL(String url) async {
    try {
      _logger.d('URL açılıyor: $url');
      final Uri uri = Uri.parse(url);

      if (await canLaunchUrl(uri)) {
        final launched = await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );
        if (launched) {
          _logger.d('URL başarıyla açıldı: $url');
        } else {
          _logger.w('URL açma işlemi başarısız oldu: $url');
        }
      } else {
        _logger.e('URL açılamıyor (canLaunchUrl false): $url');
      }
    } catch (e) {
      _logger.e('URL açılırken hata: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Kent Rehberi',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.accentGreen,

        actions: [const LanguageSwitcher(), const SizedBox(width: 8)],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildActionButton(
            context,
            'Ulusal Kent Rehberi',
            'Tüm Türkiye kent rehberine erişim',
            Icons.public,
            () => _launchURL('https://bulutkbs.gov.tr/Rehber/#/app'),
          ),
          _buildActionButton(
            context,
            'Lapseki Kent Rehberi',
            'Lapseki özel kent rehberine erişim',
            Icons.location_on,
            () => _launchURL('https://bulutkbs.gov.tr/Rehber/#/app?78974591'),
          ),
          const SizedBox(height: 8),
          _buildInfoCard(
            context,
            'Tarihçe',
            'Lapseki\'nin tarihsel gelişimi ve önemli tarihler.',
            Icons.history,
            const TarihceScreen(),
          ),
          _buildInfoCard(
            context,
            'Kültürel Zenginlik',
            'Lapseki\'nin kültürel değerleri ve gelenekleri.',
            Icons.celebration,
            null,
          ),
          _buildInfoCard(
            context,
            'El Sanatları',
            'Geleneksel el sanatları ve zanaatler.',
            Icons.brush,
            null,
          ),
          _buildInfoCard(
            context,
            'Doğal Güzellikler',
            'Lapseki\'nin doğa harikası yerleri.',
            Icons.landscape,
            null,
          ),
          _buildInfoCard(
            context,
            'Kentsel Doku',
            'Şehir planlaması ve mimari yapı.',
            Icons.location_city,
            null,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    VoidCallback onTap,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppColors.accentGreen.withValues(alpha: 0.1),
          child: Icon(icon, color: AppColors.accentGreen),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }

  Widget _buildInfoCard(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    Widget? screen,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppColors.accentGreen.withValues(alpha: 0.1),
          child: Icon(icon, color: AppColors.accentGreen),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          if (screen != null) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => screen),
            );
          }
        },
      ),
    );
  }
}
