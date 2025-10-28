import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../widgets/language_switcher.dart';

class BirimlerScreen extends StatelessWidget {
  const BirimlerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> birimler = [
      {'ad': 'ZABITA MÜDÜRLÜĞÜ', 'açıklama': 'Belediye zabıta hizmetleri'},
      {
        'ad': 'YAZI İŞLERİ MÜDÜRLÜĞÜ',
        'açıklama': 'Yazı işleri ve genel sekreterlik hizmetleri',
      },
      {
        'ad': 'İNSAN KAYNAKLARI VE EĞİTİM MÜDÜRLÜĞÜ',
        'açıklama': 'Personel işleri ve eğitim hizmetleri',
      },
      {
        'ad': 'FEN İŞLERİ MÜDÜRLÜĞÜ',
        'açıklama': 'Fen işleri ve altyapı hizmetleri',
      },
      {
        'ad': 'KÜLTÜR VE SOSYAL İŞLER MÜDÜRLÜĞÜ',
        'açıklama': 'Kültürel etkinlikler ve sosyal hizmetler',
      },
      {
        'ad': 'DESTEK HİZMETLERİ MÜDÜRLÜĞÜ',
        'açıklama': 'Genel destek hizmetleri',
      },
      {
        'ad': 'PARK BAHÇELER MÜDÜRLÜĞÜ',
        'açıklama': 'Park ve yeşil alan hizmetleri',
      },
      {
        'ad': 'İMAR VE ŞEHİRCİLİK MÜDÜRLÜĞÜ',
        'açıklama': 'İmar ve şehircilik işleri',
      },
      {
        'ad': 'İTFAİYE MÜDÜRLÜĞÜ',
        'açıklama': 'İtfaiye ve acil durum hizmetleri',
      },
      {'ad': 'MALİ HİZMETLER MÜDÜRLÜĞÜ', 'açıklama': 'Mali işler ve muhasebe'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Birimler',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.primaryBlue,
        actions: [const LanguageSwitcher(), const SizedBox(width: 8)],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.85,
        ),
        itemCount: birimler.length,
        itemBuilder: (context, index) {
          final birim = birimler[index];
          return Card(
            child: InkWell(
              onTap: () {
                // TODO: Birim detay sayfası
              },
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: AppColors.primaryBlue.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.business,
                        color: AppColors.primaryBlue,
                        size: 30,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      birim['ad']!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      birim['açıklama']!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.textSecondary,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
