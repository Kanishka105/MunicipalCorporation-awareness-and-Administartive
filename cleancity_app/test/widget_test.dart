import 'package:flutter_test/flutter_test.dart';
import 'package:cleancity_app/main.dart';

void main() {
  testWidgets('CleanCity app launches', (tester) async {
    await tester.pumpWidget(const CleanCityApp());
    expect(find.byType(CleanCityApp), findsOneWidget);
  });
}