import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../widgets/language_switcher.dart';

class VefatScreen extends StatelessWidget {
  const VefatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Vefat Edenler',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.primaryBlue,
        actions: const [LanguageSwitcher(), SizedBox(width: 8)],
      ),
      body: const Center(child: Text('Yakında eklenecek')),
    );
  }
}
