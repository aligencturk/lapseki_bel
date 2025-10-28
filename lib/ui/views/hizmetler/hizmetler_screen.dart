import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/constants/app_colors.dart';
import '../../widgets/language_switcher.dart';

class HizmetlerScreen extends StatelessWidget {
  const HizmetlerScreen({super.key});

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
          'Hizmetlerimiz',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.accentGreen,

        actions: [const LanguageSwitcher(), const SizedBox(width: 8)],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildServiceCard(
            context,
            'İmar İşleri',
            'İmar durumu, imar planları ve değişiklikler.',
            Icons.draw,
            'https://lapseki.bel.tr/hizmetlerimiz/imar-isleri',
          ),
          _buildServiceCard(
            context,
            'Yapı Kullanım',
            'Yapı kullanma izni başvuruları.',
            Icons.home_work,
            'https://lapseki.bel.tr/hizmetlerimiz/yapi-kullanim',
          ),
          _buildServiceCard(
            context,
            'İnşaat Ruhsatı',
            'İnşaat ruhsatı başvuru ve takip işlemleri.',
            Icons.engineering,
            'https://lapseki.bel.tr/hizmetlerimiz/insaat-ruhsati',
          ),
          _buildServiceCard(
            context,
            'Numarataj',
            'Bina ve daire numarataj işlemleri.',
            Icons.numbers,
            'https://lapseki.bel.tr/hizmetlerimiz/numarataj',
          ),
          _buildServiceCard(
            context,
            'Vergi İşlemleri',
            'Belediye vergi borç sorgulama.',
            Icons.receipt_long,
            'https://lapseki.bel.tr/hizmetlerimiz/vergi-islemleri',
          ),
          _buildServiceCard(
            context,
            'İşyeri Açma Ruhsatı',
            'İşyeri açma ruhsatı başvuruları.',
            Icons.store,
            'https://lapseki.bel.tr/hizmetlerimiz/isyeri-acma-ruhsati',
          ),
          _buildServiceCard(
            context,
            'Evlilik Hizmetleri',
            'Evlilik belgesi ve nikah işlemleri.',
            Icons.favorite,
            'https://lapseki.bel.tr/hizmetlerimiz/evlilik-hizmetleri',
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    String url,
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
        onTap: () => _openLink(context, url),
      ),
    );
  }
}
