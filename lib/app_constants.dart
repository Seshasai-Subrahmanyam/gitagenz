import 'package:flutter/material.dart';

class AppConstants {
  // App Info
  static const String appTitle = 'CODE DHARMA';

  // Home Page
  static const String homePageSubtitle = 'Ancient wisdom for the modern coder';
  static const String homePageButtonText = 'Begin the journey';
  static const String bannerVideoPath = 'assets/images/banner.mp4';

  // Sloka Page
  static const String slokaDataPath = 'assets/data/bhagavad_gita_data.json';
  static const String softwareIndustryTitle = 'Software Industry Application';
  static const String keyLessonTitle = 'Key Lesson:';
  static const String modernApplicationTitle = 'Modern Application:';

  // Colors
  static const Color primaryColor = Color.fromARGB(255, 235, 62, 36);
  static const Color lightScaffoldBackgroundColor = Color(0xFFFFF8E1);
  static const Color darkScaffoldBackgroundColor = Colors.black;
  static const Color lightCardColor = Color(0xFFE3F2FD); // Colors.blue[50]
  static const Color darkCardColor = Color(0xFF212121); // Colors.grey[900]

  // Font Sizes
  static const double titleDesktop = 80.0;
  static const double titleMobile = 50.0;
  static const double subtitleDesktop = 22.0;
  static const double subtitleMobile = 18.0;
  static const double buttonDesktop = 24.0;
  static const double buttonMobile = 20.0;
  static const double appBarDesktop = 24.0;
  static const double appBarMobile = 18.0;
  static const double sanskritTextSize = 22.0;
  static const double translationTextSize = 16.0;
  static const double softwareCardTitleSize = 18.0;
  static const double softwareCardBodySize = 16.0;


  // Layout Constants
  static const double mobileBreakpoint = 600.0;
  static const double wideLayoutBreakpoint = 700.0;
  static const double mobileAppBarHeight = 80.0;
}
