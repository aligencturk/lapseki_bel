import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/constants/app_colors.dart';
import '../../widgets/language_switcher.dart';

class IletisimScreen extends StatelessWidget {
  const IletisimScreen({super.key});

  Future<void> _makeCall(BuildContext context, String phone) async {
    final uri = Uri.parse('tel:$phone');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  Future<void> _sendEmail(BuildContext context, String email) async {
    final uri = Uri.parse('mailto:$email');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  Future<void> _openMaps(BuildContext context) async {
    try {
      // Lapseki Belediyesi tam adresi
      const address =
          'Cumhuriyet, Çanakkale Cd. No:2A-1, 17800 Lapseki/Çanakkale';

      // Google Maps'te tam adresi ara
      final googleMapsUri = Uri.parse(
        'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(address)}',
      );

      await launchUrl(googleMapsUri, mode: LaunchMode.externalApplication);
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Harita açılamadı')));
      }
    }
  }

  Future<void> _openWhatsApp(BuildContext context, String phoneE164) async {
    try {
      // phoneE164: 905425121044 formatında olmalı
      final uri = Uri.parse('https://wa.me/$phoneE164');
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        // Yedek: uygulama içi açmayı dene
        await launchUrl(uri, mode: LaunchMode.platformDefault);
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('WhatsApp açılamadı')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'İletişim',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.primaryBlue,

        actions: [const LanguageSwitcher(), const SizedBox(width: 8)],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Icon(
                    Icons.location_on,
                    size: 48,
                    color: AppColors.primaryBlue,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Adres',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Cumhuriyet, Çanakkale Cd. No:2A-1\n17800 Lapseki/Çanakkale',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () => _openMaps(context),
                    icon: const Icon(Icons.map),
                    label: const Text('Haritada Gör'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: AppColors.primaryBlue,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          _buildContactCard(
            context,
            'Telefon',
            '0 286 512 10 44',
            Icons.phone,
            Colors.blue,
            () => _makeCall(context, '02865121044'),
          ),
          _buildContactCard(
            context,
            'E-posta',
            'info@lapseki.bel.tr',
            Icons.email,
            Colors.red,
            () => _sendEmail(context, 'info@lapseki.bel.tr'),
          ),
          _buildContactCard(
            context,
            'WhatsApp',
            '+90 542 512 10 44',
            Icons.chat,
            Colors.green,
            () => _openWhatsApp(context, '905425121044'),
          ),
        ],
      ),
    );
  }

  Widget _buildContactCard(
    BuildContext context,
    String title,
    String value,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withValues(alpha: 0.1),
          child: Icon(icon, color: color),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(value),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}
