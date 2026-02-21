import 'package:flutter/material.dart';

class AppTheme {
  // Основна палітра кольорів
  static const Color primaryColor = Color(0xFF4CAF50); // Зелений
  static const Color secondaryColor = Color(0xFF81C784);
  static const Color backgroundColor = Color(0xFFF4F7F6);
  static const Color surfaceColor = Colors.white;
  static const Color textColor = Color(0xFF333333);
  static const Color errorColor = Color(0xFFF44336);

  // Глобальна тема додатка
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: backgroundColor,
      colorScheme: const ColorScheme.light(
        primary: primaryColor,
        secondary: secondaryColor,
        surface: surfaceColor,
        error: errorColor,
      ),
      
      // Вимикаємо анімації переходів між екранами для максимальної швидкодії
      pageTransitionsTheme: PageTransitionsTheme(
        builders: {
          TargetPlatform.android: const _NoTransitionsBuilder(),
          TargetPlatform.iOS: const _NoTransitionsBuilder(),
          TargetPlatform.windows: const _NoTransitionsBuilder(),
          TargetPlatform.macOS: const _NoTransitionsBuilder(),
          TargetPlatform.linux: const _NoTransitionsBuilder(),
        },
      ),

      // Базовий стиль тексту
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: textColor, fontSize: 16),
        bodyMedium: TextStyle(color: textColor, fontSize: 14),
        titleLarge: TextStyle(color: primaryColor, fontSize: 24, fontWeight: FontWeight.bold),
      ),

      // Стиль кнопок за замовчуванням
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          elevation: 0, // Без тіней для плаского дизайну
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}

// Кастомний клас для миттєвого переходу між екранами (без анімації)
class _NoTransitionsBuilder extends PageTransitionsBuilder {
  const _NoTransitionsBuilder();

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    // Просто повертаємо віджет без жодних Fade або Slide ефектів
    return child;
  }
}