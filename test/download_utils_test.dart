import 'package:flutter_test/flutter_test.dart';
import 'package:my_portfolio/utils/download_utils.dart';

void main() {
  group('CV Download Path Construction Logic', () {

    test('Path must be correct for English CV to avoid 404', () {
      // The EXACT path (including base path and double assets) that worked live.
      const String expectedPath =
          '/my_portfolio/assets/assets/cv/Pierre_Junior_cv_en.pdf';

      final String actualPath = DownloadUtils.cvDownloadPath('en');

      // Assertion: If this fails, the deployment link is guaranteed to be wrong.
      expect(actualPath, expectedPath,
          reason: 'English CV path is incorrect. Check base path and nested assets folder.');
    });

    test('Path must be correct for French CV', () {
      const String expectedPath =
          '/my_portfolio/assets/assets/cv/Pierre_Junior_cv_fr.pdf';

      final String actualPath = DownloadUtils.cvDownloadPath('fr');

      expect(actualPath, expectedPath,
          reason: 'French CV path is incorrect.');
    });
  });
}