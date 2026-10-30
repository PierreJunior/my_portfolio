import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:go_router/go_router.dart';
import 'package:my_portfolio/firebase_options.dart';
import 'package:my_portfolio/pages/case_study_page.dart';
import 'package:my_portfolio/pages/home_page.dart';
import 'package:my_portfolio/services/content_overrides.dart';
import 'package:my_portfolio/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Real paths (/work/kahvent) instead of /#/work/kahvent, so each case
  // study has its own shareable URL.
  usePathUrlStrategy();
  // Flutter web only builds its accessibility tree after a hidden button is
  // pressed. Turning it on up front lets screen readers (and crawlers) read
  // the page straight away.
  if (kIsWeb) SemanticsBinding.instance.ensureSemantics();
  await EasyLocalization.ensureInitialized();

  try {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  } catch (_) {
    // Site still works fully on bundled translations if Firebase can't init.
  }

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('fr')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: const MyPortfolio(),
    ),
  );
}

GoRouter buildRouter({String initialLocation = '/'}) => GoRouter(
      initialLocation: initialLocation,
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: '/work/:slug',
          builder: (context, state) => CaseStudyPage(slug: state.pathParameters['slug']!),
        ),
      ],
      errorBuilder: (context, state) => const CaseStudyPage(slug: ''),
    );

final _router = buildRouter();

class MyPortfolio extends StatelessWidget {
  final GoRouter? router;

  const MyPortfolio({super.key, this.router});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router ?? _router,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      title: 'Pierre Junior Kahozi | Full-Stack Software Developer',
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
      builder: (context, child) => _ContentSync(child: child ?? const SizedBox.shrink()),
    );
  }
}

/// Kicks off (and re-kicks off on language switch) the Firestore content
/// fetch for the active locale. Kept separate from the pages so the rest of
/// the widget tree doesn't need to know Firestore exists.
class _ContentSync extends StatefulWidget {
  final Widget child;

  const _ContentSync({required this.child});

  @override
  State<_ContentSync> createState() => _ContentSyncState();
}

class _ContentSyncState extends State<_ContentSync> {
  String? _lastLocale;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final localeCode = context.locale.languageCode;
    if (_lastLocale != localeCode) {
      _lastLocale = localeCode;
      loadContentOverrides(localeCode);
    }
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
