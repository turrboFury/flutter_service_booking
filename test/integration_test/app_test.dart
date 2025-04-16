import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:provider/provider.dart';
import 'package:flutter_service_booking/main.dart';
import 'package:flutter_service_booking/providers/appointment_provider.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('App Integration Test', () {
    testWidgets('Add an appointment and check if it appears in the list', (
      WidgetTester tester,
    ) async {
      // Start the app with Provider
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => AppointmentProvider()),
          ],
          child: AutoServiceApp(),
        ),
      );

      // Wait for UI to settle
      await tester.pumpAndSettle();

      // Find and tap the "Adaugă programare" button
      final addAppointmentButton = find.text("Adaugă programare");
      expect(addAppointmentButton, findsOneWidget);
      await tester.tap(addAppointmentButton);
      await tester.pumpAndSettle();

      // Fill in the form fields
      await tester.enterText(
        find.byType(TextFormField).at(0),
        "B123XYZ",
      ); // License Plate
      await tester.enterText(
        find.byType(TextFormField).at(1),
        "Dacia Logan",
      ); // Brand Model
      await tester.enterText(find.byType(TextFormField).at(2), "2018"); // Year
      await tester.enterText(
        find.byType(TextFormField).at(3),
        "75000",
      ); // Mileage
      await tester.enterText(
        find.byType(TextFormField).at(4),
        "Schimb ulei",
      ); // Description

      // Tap the Save button
      final saveButton = find.text("Salvează");
      await tester.tap(saveButton);
      await tester.pumpAndSettle();

      // Check if the new appointment appears in the list
      final newAppointment = find.textContaining("B123XYZ - Dacia Logan");
      expect(newAppointment, findsOneWidget);
    });

    testWidgets('Navigate to appointment details page', (
      WidgetTester tester,
    ) async {
      // Start the app
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => AppointmentProvider()),
          ],
          child: AutoServiceApp(),
        ),
      );

      await tester.pumpAndSettle();

      // Find an appointment in the list
      final appointmentItem = find.textContaining("B123XYZ - Dacia Logan");
      expect(appointmentItem, findsOneWidget);

      // Tap to navigate
      await tester.tap(appointmentItem);
      await tester.pumpAndSettle();

      // Check if the details page is opened
      final detailsTitle = find.text("Detalii B123XYZ");
      expect(detailsTitle, findsOneWidget);
    });
  });
}
