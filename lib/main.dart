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

  InputDecoration inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: GoogleFonts.plusJakartaSans(
        color: secondaryText,
        fontSize: 13,
      ),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: borderColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: borderColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: primaryOrange, width: 1.5),
      ),
    );
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bagi Biaya, Jadi Mudah.',
              style: GoogleFonts.poppins(
                fontSize: 21,
                fontWeight: FontWeight.w600,
                color: darkText,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'Hitung patungan bersama temanmu.',
              style: GoogleFonts.plusJakartaSans(
                color: secondaryText,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 25),
            Text(
              'Nama Pengeluaran',
              style: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: expenseController,
              decoration: inputDecoration('Contoh: Makan malam'),
            ),
            const SizedBox(height: 18),
            Text(
              'Total Pengeluaran',
              style: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: inputDecoration('Masukkan total biaya'),
            ),
            const SizedBox(height: 25),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryOrange,
                  foregroundColor: Colors.white,
                  elevation: 0,
                ),
                child: Text(
                  'Hitung Patungan',
                  style: GoogleFonts.plusJakartaSans(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
