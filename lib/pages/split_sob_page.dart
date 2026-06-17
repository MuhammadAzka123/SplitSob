import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../themes/app_colors.dart';
import '../widgets/participant_field.dart';
import '../widgets/expense_summary.dart';

class SplitSobPage extends StatefulWidget {
  const SplitSobPage({super.key});

  @override
  State<SplitSobPage> createState() => _SplitSobPageState();
}

class _SplitSobPageState extends State<SplitSobPage> {
  final TextEditingController expenseController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  final List<TextEditingController> participantControllers = [
    TextEditingController(),
    TextEditingController(),
  ];

  List<PembagianPeserta>? hasilPembagian;
  String namaPengeluaranHasil = '';
  int totalPengeluaranHasil = 0;

  @override
  void dispose() {
    expenseController.dispose();
    amountController.dispose();

    for (final controller in participantControllers) {
      controller.dispose();
    }

    super.dispose();
  }

  InputDecoration dekorasiInput(String hint) {
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

  void bersihkanHasil() {
    if (hasilPembagian != null) {
      setState(() {
        hasilPembagian = null;
      });
    }
  }

  void tambahPeserta() {
    setState(() {
      participantControllers.add(TextEditingController());
      hasilPembagian = null;
    });
  }

  void hapusPeserta(int index) {
    if (participantControllers.length <= 2) {
      tampilkanPesan('Minimal harus ada 2 peserta.');
      return;
    }

    final controller = participantControllers[index];

    setState(() {
      participantControllers.removeAt(index);
      hasilPembagian = null;
    });

    controller.dispose();
  }

  void tampilkanPesan(String pesan, {bool berhasil = false}) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          pesan,
          style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w500),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: berhasil ? successColor : unpaidColor,
      ),
    );
  }

  bool validasiInput() {
    final pengeluaran = expenseController.text.trim();
    final nominal = int.tryParse(amountController.text.trim());

    final namaPeserta = participantControllers
        .map((controller) => controller.text.trim())
        .toList();

    if (pengeluaran.isEmpty) {
      tampilkanPesan('Nama pengeluaran harus diisi.');
      return false;
    }

    if (nominal == null || nominal <= 0) {
      tampilkanPesan('Total pengeluaran harus lebih dari nol.');
      return false;
    }

    if (namaPeserta.length < 2) {
      tampilkanPesan('Minimal harus ada 2 peserta.');
      return false;
    }

    if (namaPeserta.any((nama) => nama.isEmpty)) {
      tampilkanPesan('Semua nama peserta harus diisi.');
      return false;
    }

    return true;
  }

  void hitungPatungan() {
    if (!validasiInput()) {
      return;
    }

    final total = int.parse(amountController.text.trim());

    final namaPeserta = participantControllers
        .map((controller) => controller.text.trim())
        .toList();

    final jumlahPeserta = namaPeserta.length;
    final bagianDasar = total ~/ jumlahPeserta;
    final sisaPembagian = total % jumlahPeserta;

    final hasil = List.generate(
      jumlahPeserta,
      (index) => PembagianPeserta(
        nama: namaPeserta[index],
        nominal: bagianDasar + (index < sisaPembagian ? 1 : 0),
      ),
    );

    setState(() {
      namaPengeluaranHasil = expenseController.text.trim();
      totalPengeluaranHasil = total;
      hasilPembagian = hasil;
    });

    tampilkanPesan('Pembagian patungan berhasil dihitung.', berhasil: true);
  }

  Widget judulBagian(String judul) {
    return Text(
      judul,
      style: GoogleFonts.plusJakartaSans(
        fontWeight: FontWeight.w600,
        fontSize: 13,
        color: darkText,
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
      body: SafeArea(
        child: SingleChildScrollView(
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
              judulBagian('Nama Pengeluaran'),
              const SizedBox(height: 8),
              TextField(
                controller: expenseController,
                onChanged: (_) => bersihkanHasil(),
                textCapitalization: TextCapitalization.sentences,
                decoration: dekorasiInput('Contoh: Makan malam'),
              ),
              const SizedBox(height: 18),
              judulBagian('Total Pengeluaran'),
              const SizedBox(height: 8),
              TextField(
                controller: amountController,
                onChanged: (_) => bersihkanHasil(),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: dekorasiInput('Masukkan total biaya'),
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
                (index) => ParticipantField(
                  key: ValueKey(participantControllers[index]),
                  nomor: index + 1,
                  controller: participantControllers[index],
                  onHapus: () => hapusPeserta(index),
                  onChanged: bersihkanHasil,
                  dekorasiInput: dekorasiInput,
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: tambahPeserta,
                  icon: const Icon(Icons.add, color: primaryDark, size: 19),
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
                  onPressed: hitungPatungan,
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
              if (hasilPembagian != null) ...[
                const SizedBox(height: 25),
                ExpenseSummary(
                  namaPengeluaran: namaPengeluaranHasil,
                  totalPengeluaran: totalPengeluaranHasil,
                  peserta: hasilPembagian!,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
