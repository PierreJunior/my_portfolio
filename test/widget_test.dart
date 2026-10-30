import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_portfolio/lang/codegen_loader.g.dart';
import 'package:my_portfolio/main.dart';
import 'package:my_portfolio/theme/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> _pumpSite(WidgetTester tester, {String location = '/', Size size = const Size(1440, 1000)}) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);

  await tester.pumpWidget(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('fr')],
      path: 'assets/translations',
      assetLoader: const CodegenLoader(),
      fallbackLocale: const Locale('en'),
      startLocale: const Locale('en'),
      child: MyPortfolio(router: buildRouter(initialLocation: location)),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  setUpAll(() async {
    AppFonts.useGoogleFonts = false;
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
  });

  testWidgets('home shows hero, case studies and Kamoto Copper Company', (tester) async {
    await _pumpSite(tester);

    expect(find.text('I build enterprise web apps and the mobile apps people carry.'), findsOneWidget);
    expect(find.text('Kahvent'), findsOneWidget);
    expect(find.text('DELIVERED FOR AKROTECH · RETIRED'), findsNWidgets(2));
    expect(find.textContaining('Kamoto Copper Company'), findsOneWidget);
    expect(find.textContaining('APCMS'), findsNothing);
    expect(find.textContaining('KCC'), findsNothing);
  });

  testWidgets('phone layout puts the nav in a drawer', (tester) async {
    await _pumpSite(tester, size: const Size(390, 844));

    expect(find.byTooltip('Open menu'), findsOneWidget);
    await tester.tap(find.byTooltip('Open menu'));
    await tester.pumpAndSettle();
    expect(find.text('Experience'), findsOneWidget);
  });

  testWidgets('language switch changes the copy to French', (tester) async {
    await _pumpSite(tester);

    await tester.tap(find.text('FR'));
    await tester.pumpAndSettle();
    expect(find.text('Études de cas'), findsOneWidget);
  });

  testWidgets('case study route renders its sections', (tester) async {
    await _pumpSite(tester, location: '/work/kahvent');

    expect(find.text('Kahvent: one link that is the invitation and the entry pass'), findsOneWidget);
    expect(find.text('The problem'), findsOneWidget);
    expect(find.text('Permissions live in the database'), findsOneWidget);
    expect(find.text('Results so far'), findsNothing);
  });

  testWidgets('unknown case study shows a not-found message', (tester) async {
    await _pumpSite(tester, location: '/work/apcms');

    expect(find.text("This case study doesn't exist."), findsOneWidget);
  });
}
