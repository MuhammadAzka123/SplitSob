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

  final List<TextEditingController> participantControllers = [
    TextEditingController(),
    TextEditingController(),
  ];

  @override
  void dispose() {
    expenseController.dispose();
    amountController.dispose();

    for (final controller in participantControllers) {
      controller.dispose();
    }

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
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 14,
      ),
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
        borderSide: const BorderSide(
          color: primaryOrange,
          width: 1.5,
        ),
      ),
    );
  }

  void addParticipant() {
    setState(() {
      participantControllers.add(TextEditingController());
    });
  }

  void removeParticipant(int index) {
    if (participantControllers.length <= 2) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Minimal harus ada 2 peserta.',
            style: GoogleFonts.plusJakartaSans(),
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: darkText,
        ),
      );
      return;
    }

    final controller = participantControllers[index];

    setState(() {
      participantControllers.removeAt(index);
    });

    controller.dispose();
  }

  Widget buildParticipantField(int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: lightOrange,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              '${index + 1}',
              style: GoogleFonts.plusJakartaSans(
                color: primaryDark,
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: participantControllers[index],
              textCapitalization: TextCapitalization.words,
              decoration: inputDecoration(
                'Nama peserta ${index + 1}',
              ),
            ),
          ),
          const SizedBox(width: 5),
          IconButton(
            onPressed: () => removeParticipant(index),
            tooltip: 'Hapus peserta',
            icon: const Icon(
              Icons.delete_outline,
              color: unpaidColor,
              size: 21,
            ),
          ),
        ],
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
        backgroundColor: backgroundColor,
        surfaceTintColor: Colors.transparent,
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
                color: darkText,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: expenseController,
              textCapitalization: TextCapitalization.sentences,
              decoration: inputDecoration('Contoh: Makan malam'),
            ),
            const SizedBox(height: 18),
            Text(
              'Total Pengeluaran',
              style: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.w600,
                fontSize: 13,
                color: darkText,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: inputDecoration('Masukkan total biaya'),
            ),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Daftar Peserta',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    color: darkText,
                  ),
                ),
                Text(
                  '${participantControllers.length} Orang',
                  style: GoogleFonts.plusJakartaSans(
                    color: secondaryText,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...List.generate(
              participantControllers.length,
              (index) => buildParticipantField(index),
            ),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: addParticipant,
                icon: const Icon(
                  Icons.add,
                  color: primaryDark,
                  size: 19,
                ),
                label: Text(
                  'Tambah Peserta',
                  style: GoogleFonts.plusJakartaSans(
                    color: primaryDark,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: primaryOrange),
                  padding: const EdgeInsets.symmetric(vertical: 13),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 25),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryDark,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
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
