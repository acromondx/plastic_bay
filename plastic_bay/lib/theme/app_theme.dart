import 'package:flutter/material.dart';
import 'package:plastic_bay/theme/app_color.dart';

class AppTheme {
  static TextTheme lightTextTheme = TextTheme(
    displayLarge: TextStyle(
      fontFamily: "Nunito",
      fontSize: 16.0,
      fontWeight: FontWeight.w800,
      color: AppColors.secondaryColor,
    ),
    displaySmall: const TextStyle(
      fontFamily: "Nunito",
      fontSize: 15.0,
      fontWeight: FontWeight.w800,
      color: AppColors.primaryColor,
    ),
    displayMedium: TextStyle(
      fontWeight: FontWeight.w500,
      fontFamily: "Nunito",
      fontSize: 16.0,
      color: AppColors.secondaryColor,
    ),
    titleMedium: const TextStyle(
      fontFamily: "Nunito",
      fontSize: 13.0,
      color: AppColors.primaryColor,
    ),
    titleLarge: const TextStyle(
      fontFamily: "Nunito",
      fontSize: 24.0,
      color: AppColors.primaryColor,
    ),
    bodyMedium: const TextStyle(
      fontFamily: "Nunito",
      fontSize: 15.0,
      color: Colors.black,
    ),
  );
  static ThemeData light() {
    return ThemeData(
      canvasColor: AppColors.darkGreyColor,
      colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: AppColors.primaryColor,
          onPrimary: Colors.white,
          onPrimaryContainer: Colors.amber,
          secondary: AppColors.primaryColor.withOpacity(0.3),
          onSecondary: Colors.black,
          error: Colors.red,
          onError: Colors.pink,
          background: AppColors.primaryColor.withOpacity(0.3),
          onBackground: Colors.black,
          surface: AppColors.primaryColor,
          onSurface: Colors.black,
          surfaceTint: AppColors.primaryColor),

      indicatorColor: AppColors.primaryColor,
      primaryColor: AppColors.primaryColor,
      // primarySwatch: convertColor(0xFF1C3A88),
      useMaterial3: true,
      // AppColors.primaryColor: AppColors.primaryColor,
      brightness: Brightness.light,
      // canvasColor: Colors.green,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(
        surfaceTintColor: Colors.transparent,
        // foregroundColor: Colors.green,
        centerTitle: true,
        shadowColor: Colors.transparent,
        backgroundColor: Colors.white,
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.w700,
          fontFamily: 'Nunito',
          fontSize: 20,
          color: Colors.black,
        ),
      ),
      
      datePickerTheme: const DatePickerThemeData(
          backgroundColor: Colors.white,
          shadowColor: AppColors.primaryColor,
          surfaceTintColor: AppColors.primaryColor,
          rangePickerBackgroundColor: Colors.red),
      timePickerTheme: TimePickerThemeData(
        backgroundColor: Colors.white,
        hourMinuteColor: AppColors.secondaryColor,
        dayPeriodColor: AppColors.secondaryColor,
        hourMinuteTextStyle: const TextStyle(
          fontWeight: FontWeight.w400,
          fontFamily: 'Nunito',
          fontSize: 18,
          color: Colors.black,
        ),
        dayPeriodTextStyle: const TextStyle(
          fontWeight: FontWeight.w400,
          fontFamily: 'Nunito',
          fontSize: 18,
          color: Colors.black,
        ),
        dialHandColor: Colors.amber,
        dialBackgroundColor: AppColors.secondaryColor,
        dayPeriodTextColor: AppColors.secondaryColor,
        inputDecorationTheme: const InputDecorationTheme(
          labelStyle: TextStyle(
            fontWeight: FontWeight.w700,
            fontFamily: 'Nunito',
            fontSize: 20,
            color: Colors.black,
          ),
        ),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        labelStyle: TextStyle(
          fontWeight: FontWeight.w700,
          fontFamily: 'Nunito',
          fontSize: 20,
          color: Colors.black,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primaryColor,
          textStyle: const TextStyle(
              fontFamily: 'Nunito',
              fontSize: 16,
              color: AppColors.primaryColor,
              fontWeight: FontWeight.normal),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            textStyle: const TextStyle(
                fontFamily: 'Nunito',
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.normal),
            minimumSize: const Size(double.infinity, 60),
            backgroundColor: AppColors.primaryColor),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          extendedTextStyle:
              TextStyle(fontWeight: FontWeight.bold, fontFamily: "Quicksand"),
          foregroundColor: Colors.white,
          backgroundColor: AppColors.primaryColor,
          elevation: 5),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: AppColors.primaryColor,
          unselectedItemColor: Colors.grey.shade900,
          selectedLabelStyle:
              lightTextTheme.displayMedium!.copyWith(fontSize: 14),
          unselectedLabelStyle:
              lightTextTheme.displayMedium!.copyWith(fontSize: 14),
          type: BottomNavigationBarType.fixed),
      textTheme: lightTextTheme,
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return null;
          }
          if (states.contains(MaterialState.selected)) {
            return Colors.amber;
          }
          return null;
        }),
      ),
      chipTheme: const ChipThemeData(elevation: 0,),

      radioTheme: RadioThemeData(
        fillColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return null;
          }
          if (states.contains(MaterialState.selected)) {
            return AppColors.primaryColor;
          }
          return null;
        }),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return null;
          }
          if (states.contains(MaterialState.selected)) {
            return Colors.amber;
          }
          return null;
        }),
        trackColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return null;
          }
          if (states.contains(MaterialState.selected)) {
            return Colors.amber;
          }
          return null;
        }),
      ),
    );
  }
}
