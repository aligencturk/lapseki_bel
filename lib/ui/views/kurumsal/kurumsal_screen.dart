import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../widgets/language_switcher.dart';
import 'birimler_screen.dart';

class KurumsalScreen extends StatelessWidget {
  const KurumsalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Kurumsal',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.primaryBlue,

        actions: [const LanguageSwitcher(), const SizedBox(width: 8)],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSectionCard(
            context,
            'Birimler',
            'Fen İşleri, İmar Müdürlüğü, Kültür ve Sosyal İşler gibi tüm birimlerimiz.',
            Icons.business,
            const BirimlerScreen(),
          ),
          _buildSectionCard(
            context,
            'Meclis',
            'Meclis Gündemi, Üyeler, Kararları ve Meclis hakkında bilgiler.',
            Icons.people,
            null,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard(
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
          backgroundColor: AppColors.primaryBlue.withValues(alpha: 0.1),
          child: Icon(icon, color: AppColors.primaryBlue),
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
