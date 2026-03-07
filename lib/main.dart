import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'pages/split_sob_page.dart';
import 'themes/app_colors.dart';

void main() {
  runApp(const SplitSobApp());
}

class SplitSobApp extends StatelessWidget {
  const SplitSobApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SplitSob',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: backgroundColor,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryOrange,
          brightness: Brightness.light,
        ),
        fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
      ),
      home: const SplitSobPage(),
    );
  }
}
