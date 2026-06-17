import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../themes/app_colors.dart';

class PembagianPeserta {
  final String nama;
  final int nominal;

  const PembagianPeserta({required this.nama, required this.nominal});
}

class ExpenseSummary extends StatelessWidget {
  final String namaPengeluaran;
  final int totalPengeluaran;
  final List<PembagianPeserta> peserta;

  const ExpenseSummary({
    super.key,
    required this.namaPengeluaran,
    required this.totalPengeluaran,
    required this.peserta,
  });

  String formatRupiah(int nominal) {
    final angka = nominal.toString();

    final hasil = angka.replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
      (match) => '.',
    );

    return 'Rp $hasil';
  }

  Widget buildInfoTotal() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: lightOrange,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total Pengeluaran',
                  style: GoogleFonts.plusJakartaSans(
                    color: secondaryText,
                    fontSize: 11,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  formatRupiah(totalPengeluaran),
                  style: GoogleFonts.poppins(
                    color: primaryDark,
                    fontSize: 19,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Peserta',
                style: GoogleFonts.plusJakartaSans(
                  color: secondaryText,
                  fontSize: 11,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                '${peserta.length} Orang',
                style: GoogleFonts.poppins(
                  color: darkText,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildParticipant(PembagianPeserta orang) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 9),
      child: Row(
        children: [
          CircleAvatar(
            radius: 17,
            backgroundColor: lightOrange,
            child: Text(
              orang.nama[0].toUpperCase(),
              style: GoogleFonts.plusJakartaSans(
                color: primaryDark,
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              orang.nama,
              style: GoogleFonts.plusJakartaSans(
                color: darkText,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Text(
            formatRupiah(orang.nominal),
            style: GoogleFonts.plusJakartaSans(
              color: primaryDark,
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: lightOrange,
                  borderRadius: BorderRadius.circular(11),
                ),
                child: const Icon(
                  Icons.receipt_long_rounded,
                  color: primaryDark,
                  size: 21,
                ),
              ),
              const SizedBox(width: 11),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ringkasan Patungan',
                      style: GoogleFonts.poppins(
                        color: darkText,
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      namaPengeluaran,
                      style: GoogleFonts.plusJakartaSans(
                        color: secondaryText,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.check_circle_rounded,
                color: successColor,
                size: 22,
              ),
            ],
          ),
          const SizedBox(height: 20),
          buildInfoTotal(),
          const SizedBox(height: 20),
          Text(
            'Pembagian Biaya',
            style: GoogleFonts.poppins(
              color: darkText,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          ...peserta.map(buildParticipant),
          const Divider(color: borderColor, height: 20),
          Row(
            children: [
              const Icon(
                Icons.check_circle_outline,
                color: successColor,
                size: 16,
              ),
              const SizedBox(width: 7),
              Expanded(
                child: Text(
                  'Total pembagian sesuai dengan pengeluaran.',
                  style: GoogleFonts.plusJakartaSans(
                    color: secondaryText,
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
