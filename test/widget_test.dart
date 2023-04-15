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
    expect(find.text('Expense Splitter App'), findsOneWidget);
  });
}