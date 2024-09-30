import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_builder/responsive_builder.dart';

final class AppTheme {
  static ThemeData _baseTheme({
    required ColorScheme colorScheme,
    required Brightness brightness,
  }) =>
      ThemeData(
        brightness: brightness,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: switch (brightness) {
          Brightness.dark => GoogleFonts.ptMonoTextTheme().apply(
              bodyColor: colorScheme.primary,
              displayColor: colorScheme.primary,
            ),
          Brightness.light => GoogleFonts.robotoTextTheme().apply(
              bodyColor: colorScheme.onSurface,
              displayColor: colorScheme.onSurface,
            ),
        },
      );

  static ThemeData generateThemeData({
    required ColorScheme colorScheme,
    required Brightness brightness,
  }) {
    return _baseTheme(colorScheme: colorScheme, brightness: brightness)
        .copyWith(
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.surface,
      menuButtonTheme: MenuButtonThemeData(
        style: MenuItemButton.styleFrom(
          minimumSize: const Size(160, 56),
          padding: const EdgeInsets.fromLTRB(16, 0, 20, 0),
        ),
      ),
      popupMenuTheme: switch (brightness) {
        Brightness.dark => PopupMenuThemeData(
            shape: RoundedRectangleBorder(
              side: BorderSide(color: colorScheme.primary),
            ),
          ),
        Brightness.light => const PopupMenuThemeData(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
          ),
      },
      snackBarTheme: switch (brightness) {
        Brightness.dark => SnackBarThemeData(
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: colorScheme.primary),
            ),
          ),
        Brightness.light => const SnackBarThemeData(
            behavior: SnackBarBehavior.floating,
          ),
      },
      inputDecorationTheme: switch (brightness) {
        Brightness.dark => InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.zero,
              borderSide: BorderSide(color: colorScheme.primary),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.zero,
              borderSide: BorderSide(color: colorScheme.primary, width: 2),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.zero,
              borderSide: BorderSide(color: colorScheme.primary),
            ),
          ),
        Brightness.light => const InputDecorationTheme(
            border: OutlineInputBorder(),
          ),
      },
      appBarTheme: switch (brightness) {
        Brightness.dark => AppBarTheme(
            elevation: 0,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: colorScheme.primary, width: 2),
            ),
          ),
        Brightness.light => const AppBarTheme(),
      },
      dropdownMenuTheme: switch (brightness) {
        Brightness.dark => DropdownMenuThemeData(
            inputDecorationTheme: InputDecorationTheme(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.zero,
                borderSide: BorderSide(color: colorScheme.primary),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            ),
          ),
        Brightness.light => const DropdownMenuThemeData(
            inputDecorationTheme: InputDecorationTheme(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 16),
            ),
          ),
      },
      menuTheme: switch (brightness) {
        Brightness.dark => MenuThemeData(
            style: MenuStyle(
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(
                  side: BorderSide(color: colorScheme.primary),
                ),
              ),
            ),
          ),
        Brightness.light => const MenuThemeData(
            style: MenuStyle(),
          ),
      },
      cardTheme: switch (brightness) {
        Brightness.dark => CardTheme(
            shape: RoundedRectangleBorder(
              side: BorderSide(color: colorScheme.primary),
            ),
            clipBehavior: Clip.antiAlias,
          ),
        Brightness.light => const CardTheme(
            clipBehavior: Clip.antiAlias,
          ),
      },
      filledButtonTheme: switch (brightness) {
        Brightness.dark => FilledButtonThemeData(
            style: FilledButton.styleFrom(
              minimumSize: const Size(48, 48),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(4)),
              ),
              backgroundColor: colorScheme.secondary,
            ),
          ),
        Brightness.light => FilledButtonThemeData(
            style: FilledButton.styleFrom(
              minimumSize: const Size(48, 48),
            ),
          ),
      },
    );
  }
}

typedef WidgetBuilder = Widget Function(BuildContext context, Widget? child);

class ScreenTypeBuilder extends StatelessWidget {
  const ScreenTypeBuilder({
    required this.mobile,
    this.watch,
    this.tablet,
    this.desktop,
    this.child,
    super.key,
  });

  final WidgetBuilder? watch;
  final WidgetBuilder mobile;
  final WidgetBuilder? tablet;
  final WidgetBuilder? desktop;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return getValueForScreenType(
      context: context,
      mobile: mobile(context, child),
      tablet: tablet == null ? null : tablet!(context, child),
      desktop: desktop == null ? null : desktop!(context, child),
      watch: watch == null ? null : watch!(context, child),
    );
  }
}
