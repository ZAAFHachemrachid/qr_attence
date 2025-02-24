import 'package:flutter/material.dart';

@immutable
class AppThemeExtension extends ThemeExtension<AppThemeExtension> {
  const AppThemeExtension({
    required this.success,
    required this.danger,
    required this.warning,
    required this.info,
    required this.headingLarge,
    required this.headingMedium,
    required this.headingSmall,
    required this.bodyLarge,
    required this.bodyMedium,
    required this.bodySmall,
  });

  final Color success;
  final Color danger;
  final Color warning;
  final Color info;
  final TextStyle headingLarge;
  final TextStyle headingMedium;
  final TextStyle headingSmall;
  final TextStyle bodyLarge;
  final TextStyle bodyMedium;
  final TextStyle bodySmall;

  @override
  ThemeExtension<AppThemeExtension> copyWith({
    Color? success,
    Color? danger,
    Color? warning,
    Color? info,
    TextStyle? headingLarge,
    TextStyle? headingMedium,
    TextStyle? headingSmall,
    TextStyle? bodyLarge,
    TextStyle? bodyMedium,
    TextStyle? bodySmall,
  }) {
    return AppThemeExtension(
      success: success ?? this.success,
      danger: danger ?? this.danger,
      warning: warning ?? this.warning,
      info: info ?? this.info,
      headingLarge: headingLarge ?? this.headingLarge,
      headingMedium: headingMedium ?? this.headingMedium,
      headingSmall: headingSmall ?? this.headingSmall,
      bodyLarge: bodyLarge ?? this.bodyLarge,
      bodyMedium: bodyMedium ?? this.bodyMedium,
      bodySmall: bodySmall ?? this.bodySmall,
    );
  }

  @override
  ThemeExtension<AppThemeExtension> lerp(
    covariant ThemeExtension<AppThemeExtension>? other,
    double t,
  ) {
    if (other is! AppThemeExtension) {
      return this;
    }
    return AppThemeExtension(
      success: Color.lerp(success, other.success, t)!,
      danger: Color.lerp(danger, other.danger, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      info: Color.lerp(info, other.info, t)!,
      headingLarge: TextStyle.lerp(headingLarge, other.headingLarge, t)!,
      headingMedium: TextStyle.lerp(headingMedium, other.headingMedium, t)!,
      headingSmall: TextStyle.lerp(headingSmall, other.headingSmall, t)!,
      bodyLarge: TextStyle.lerp(bodyLarge, other.bodyLarge, t)!,
      bodyMedium: TextStyle.lerp(bodyMedium, other.bodyMedium, t)!,
      bodySmall: TextStyle.lerp(bodySmall, other.bodySmall, t)!,
    );
  }

  static get light => AppThemeExtension(
        success: const Color(0xFF28A745),
        danger: const Color(0xFFDC3545),
        warning: const Color(0xFFFFC107),
        info: const Color(0xFF17A2B8),
        headingLarge: Typography.material2021().englishLike.headlineLarge!,
        headingMedium: Typography.material2021().englishLike.headlineMedium!,
        headingSmall: Typography.material2021().englishLike.headlineSmall!,
        bodyLarge: Typography.material2021().englishLike.bodyLarge!,
        bodyMedium: Typography.material2021().englishLike.bodyMedium!,
        bodySmall: Typography.material2021().englishLike.bodySmall!,
      );

  static get dark => light.copyWith(
        success: const Color(0xFF2FB344),
        danger: const Color(0xFFE04252),
        warning: const Color(0xFFFFCA2C),
        info: const Color(0xFF20C3DC),
      );
}
