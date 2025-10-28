import 'package:flutter/material.dart';

/// Lapseki Belediyesi tema renkleri
class AppColors {
  // Logo renkleri
  static const Color primaryBlue = Color(0xFF0047AB); // Mavi
  static const Color accentRed = Color(0xFFE30613); // Kırmızı - Elma
  static const Color accentGreen = Color(0xFF00843D); // Yeşil - Yaprak
  
  // UI renkleri
  static const Color backgroundColor = Color(0xFFF5F5F5);
  static const Color cardColor = Colors.white;
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color dividerColor = Color(0xFFE0E0E0);
  
  // Durum renkleri
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color error = Color(0xFFF44336);
  static const Color info = Color(0xFF2196F3);
  
  // Gradient renkleri
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryBlue, Color(0xFF003087)],
  );
  
  static const LinearGradient redGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [accentRed, Color(0xFFB8050F)],
  );
  
  static const LinearGradient greenGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [accentGreen, Color(0xFF005F2A)],
  );
}

