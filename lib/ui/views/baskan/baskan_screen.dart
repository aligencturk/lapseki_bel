import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../widgets/language_switcher.dart';

class BaskanScreen extends StatelessWidget {
  const BaskanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Başkan',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.accentRed,

        actions: [const LanguageSwitcher(), const SizedBox(width: 8)],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Başkan fotoğrafı
            Container(
              width: 200,
              height: 200,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: ClipOval(
                child: Image.asset(
                  'assets/images/baskan-foto-web_1.jpg',
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      decoration: const BoxDecoration(
                        gradient: AppColors.primaryGradient,
                      ),
                      child: const Icon(
                        Icons.person,
                        size: 100,
                        color: Colors.white,
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Atilla ÖZTÜRK',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Lapseki Belediye Başkanı',
              style: TextStyle(fontSize: 18, color: AppColors.textSecondary),
            ),
            const SizedBox(height: 32),
            Card(
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Biyografi',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      '1985 yılında, Çanakkale\'nin Lapseki ilçesinde doğdu. İlköğretimi Lapseki\'de, ortaöğretim ve liseyi Çanakkale\'de tamamladı. Celal Bayar Üniversitesi Mühendislik Fakültesi İnşaat Mühendisliği Bölümünden 2008 yılında mezun oldu.',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.textSecondary,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      '2010-2012 yılları arasında "Lapseki Belediyesi Fen ve İmar İşleri Müdür Vekili", 2019-2021 yılları arasında Çanakkale İnşaat Mühendisleri Odası "Yönetim Kurulu Üyesi", 2021-2023 yılları arasında "Şube Başkanı" olarak görev aldı.',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.textSecondary,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      '31 Mart 2024 tarihinde Lapseki Belediye Başkanlığı görevine seçildi. Evli ve 3 çocuk babasıdır.',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.textSecondary,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'İletişim',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ListTile(
                      leading: const Icon(
                        Icons.phone,
                        color: AppColors.primaryBlue,
                      ),
                      title: const Text('Telefon'),
                      subtitle: const Text('0 286 512 10 44'),
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.email,
                        color: AppColors.accentRed,
                      ),
                      title: const Text('E-posta'),
                      subtitle: const Text('info@lapseki.bel.tr'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
