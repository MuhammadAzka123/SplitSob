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
}
