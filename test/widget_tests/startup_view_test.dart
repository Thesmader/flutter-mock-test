import 'package:flutter_test/flutter_test.dart';
import 'package:my_app/main.dart';
import 'package:my_app/ui/views/startup/startup_view.dart';

import '../setup/test_helpers.dart';

void main() {
  setUp(() => registerServices());
  tearDown(() => unregisterServices());

  testWidgets('runApp runs MyApp', (WidgetTester tester) async {
    await tester.pump();
  });
  testWidgets('StartupView has a title and a button',
      (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    final titleFinder = find.text("Start up view");
    expect(titleFinder, findsOneWidget);
  });
}
