import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../viewmodels/locale_viewmodel.dart';

class LanguageSwitcher extends StatelessWidget {
  const LanguageSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    final currentLocale = Localizations.localeOf(context);

    return PopupMenuButton<Locale>(
      icon: const Icon(Icons.language, color: Colors.white),
      onSelected: (locale) {
        context.read<LocaleViewModel>().setLocale(locale);
      },
      itemBuilder: (context) => [
        PopupMenuItem<Locale>(
          value: const Locale('tr'),
          child: Row(
            children: [
              if (currentLocale.languageCode == 'tr')
                const Icon(Icons.check, color: AppColors.accentRed, size: 20)
              else
                const SizedBox(width: 20),
              const SizedBox(width: 8),
              const Text('Türkçe'),
            ],
          ),
        ),
        PopupMenuItem<Locale>(
          value: const Locale('en'),
          child: Row(
            children: [
              if (currentLocale.languageCode == 'en')
                const Icon(Icons.check, color: AppColors.accentRed, size: 20)
              else
                const SizedBox(width: 20),
              const SizedBox(width: 8),
              const Text('English'),
            ],
          ),
        ),
      ],
    );
  }
}
