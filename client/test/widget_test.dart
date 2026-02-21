import 'package:flutter_test/flutter_test.dart';
import 'package:client/main.dart';

void main() {
  testWidgets('App startup test', (WidgetTester tester) async {
    // Запускаємо наш новий додаток
    await tester.pumpWidget(const CalorieTrackerApp());

    // Перевіряємо, чи з'явився текст на екрані
    expect(find.text('Клієнт успішно запущено!'), findsOneWidget);
  });
}
