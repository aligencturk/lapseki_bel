import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../widgets/language_switcher.dart';

class NobetciEczaneScreen extends StatelessWidget {
  const NobetciEczaneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Nöbetçi Eczaneler',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.primaryBlue,
        actions: const [LanguageSwitcher(), SizedBox(width: 8)],
      ),
      body: const Center(child: Text('Yakında eklenecek')),
    );
  }
}
