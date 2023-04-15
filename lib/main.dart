import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const SplitSobApp());
}

const Color primaryOrange = Color(0xFFFF7A1A);
const Color primaryDark = Color(0xFFEA580C);
const Color lightOrange = Color(0xFFFFF7ED);
const Color backgroundColor = Color(0xFFFFFFFF);
const Color darkText = Color(0xFF1F2937);
const Color secondaryText = Color(0xFF6B7280);
const Color successColor = Color(0xFF16A34A);
const Color unpaidColor = Color(0xFFDC2626);
const Color borderColor = Color(0xFFE5E7EB);

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
      home: const SplitSobHomePage(),
    );
  }
}

class SplitSobHomePage extends StatefulWidget {
  const SplitSobHomePage({super.key});

  @override
  State<SplitSobHomePage> createState() => _SplitSobHomePageState();
}

class _SplitSobHomePageState extends State<SplitSobHomePage> {
  final TextEditingController expenseController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  @override
  void dispose() {
    expenseController.dispose();
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'SplitSob',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w700,
            color: darkText,
          ),
        ),
      ),
      body: const Center(
        child: Text('Expense Splitter App'),
      ),
    );
  }
}
