import 'package:flutter_test/flutter_test.dart';
import 'package:my_portfolio/models/data.dart'; // Import the file with the logic

void main() {
  // Group tests related to the CV URL selection logic.
  group('DeveloperProfile.getCvUrl', () {

    // Test case 1: Verify it returns the English URL for 'en'.
    test('returns English URL for language code "en"', () {
      // 1. Arrange: Define the input language code.
      const langCode = 'en';

      // 2. Act: Call the function being tested.
      final result = DeveloperProfile.getCvUrl(langCode);

      // 3. Assert: Check if the result is the expected English URL.
      expect(result, DeveloperProfile.cvUrlEn);
    });

    // Test case 2: Verify it returns the French URL for 'fr'.
    test('returns French URL for language code "fr"', () {
      // Act
      final result = DeveloperProfile.getCvUrl('fr');

      // Assert
      expect(result, DeveloperProfile.cvUrlFr);
    });

    // Test case 3: Verify it falls back to the English URL for any other code.
    test('defaults to English URL for unknown language codes', () {
      // Act
      final result = DeveloperProfile.getCvUrl('de'); // Using German as an example

      // Assert
      expect(result, DeveloperProfile.cvUrlEn);
    });
  });
}