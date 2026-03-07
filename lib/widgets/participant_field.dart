import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../themes/app_colors.dart';

class ParticipantField extends StatelessWidget {
  final int nomor;
  final TextEditingController controller;
  final VoidCallback onHapus;
  final InputDecoration Function(String) dekorasiInput;

  const ParticipantField({
    super.key,
    required this.nomor,
    required this.controller,
    required this.onHapus,
    required this.dekorasiInput,
  });

  @override
  Widget build(BuildContext context) {
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
              '$nomor',
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
              controller: controller,
              textCapitalization: TextCapitalization.words,
              decoration: dekorasiInput('Nama peserta $nomor'),
            ),
          ),
          const SizedBox(width: 5),
          IconButton(
            onPressed: onHapus,
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
}
