import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:splitsob/main.dart';

void main() {
  setUpAll(() {
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  testWidgets('SplitSob app renders successfully', (WidgetTester tester) async {
    await tester.pumpWidget(const SplitSobApp());

    expect(find.text('SplitSob'), findsOneWidget);
    expect(find.text('Bagi Biaya, Jadi Mudah.'), findsOneWidget);
    expect(find.text('Daftar Peserta'), findsOneWidget);
    expect(find.text('2 Orang'), findsOneWidget);
  });

  testWidgets('Tambah peserta berfungsi', (WidgetTester tester) async {
    await tester.pumpWidget(const SplitSobApp());

    await tester.tap(find.text('Tambah Peserta'));
    await tester.pump();

    expect(find.text('3 Orang'), findsOneWidget);
  });

  testWidgets('Hitung patungan membagi biaya dengan benar', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const SplitSobApp());

    await tester.enterText(find.byType(TextField).at(0), 'Makan malam');

    await tester.enterText(find.byType(TextField).at(1), '100000');

    await tester.enterText(find.byType(TextField).at(2), 'Azka');

    await tester.enterText(find.byType(TextField).at(3), 'Budi');

    await tester.ensureVisible(find.text('Tambah Peserta'));
    await tester.tap(find.text('Tambah Peserta'));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField).at(4), 'Citra');

    await tester.ensureVisible(find.text('Hitung Patungan'));
    await tester.tap(find.text('Hitung Patungan'));
    await tester.pumpAndSettle();

    expect(find.text('Hasil Pembagian'), findsOneWidget);
    expect(find.text('Rp 100.000'), findsOneWidget);
    expect(find.text('Rp 33.334'), findsOneWidget);
    expect(find.text('Rp 33.333'), findsNWidgets(2));
  });
}
