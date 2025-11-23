import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:my_portfolio/lang/locale_keys.g.dart';
import 'package:url_launcher/url_launcher.dart';

// IMPORTS: Ensure these files exist based on our previous steps
import 'models/data.dart';
import 'sections/about_section.dart';
import 'sections/projects_carousel.dart';
import 'sections/footer_section.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('fr')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: const MyPortfolio(),
    ),
  );
}

class MyPortfolio extends StatelessWidget {
  const MyPortfolio({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      title: 'Pierre Junior | Flutter Developer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Using a professional blue widely used in enterprise tech
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1565C0)),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: -1.5,
          ),
        ),
      ),
      home: const PortfolioHome(),
    );
  }
}

class PortfolioHome extends StatelessWidget {
  const PortfolioHome({super.key});

  // Helper for scrolling to sections
  void _scrollToSection(GlobalKey key) {
    Scrollable.ensureVisible(
      key.currentContext!,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Keys for programmatic scrolling
    final aboutKey = GlobalKey();
    final experienceKey = GlobalKey();
    final projectsKey = GlobalKey();
    final contactKey = GlobalKey();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white.withValues(alpha: 0.95),
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        // inside PortfolioHome -> Scaffold -> AppBar
        title: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 1. The Custom Logo
              const LogoWidget(),

              const SizedBox(width: 12),

              // 2. The Text Name
              Text(
                "Pierre Junior",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface, // Darker, cleaner text
                  letterSpacing: -0.5,
                ),
              ),
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: DropdownButton(
              value: context.supportedLocales.contains(context.locale)
                  ? context.locale
                  : const Locale('en'),
              items: const [
                DropdownMenuItem(value: Locale('en'), child: Text('EN')),
                DropdownMenuItem(value: Locale('fr'), child: Text('FR')),
              ],
              onChanged: (Locale? newLocale) {
                if (newLocale != null) {
                  context.setLocale(newLocale);
                }
              },
            ),
          ),
          _NavBarItem(
            title: LocaleKeys.nav_about.tr(),
            onTap: () => _scrollToSection(aboutKey),
          ),
          _NavBarItem(
            title: LocaleKeys.nav_experience.tr(),
            onTap: () => _scrollToSection(experienceKey),
          ),
          _NavBarItem(
            title: LocaleKeys.nav_projects.tr(),
            onTap: () => _scrollToSection(projectsKey),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20, left: 10),
            child: FilledButton(
              onPressed: () => _scrollToSection(contactKey),
              child: Text(LocaleKeys.nav_contact.tr()),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1. Hero Section
            _HeroSection(onCtaTap: () => _scrollToSection(projectsKey)),

            // 2. About Section (Imported)
            SizedBox(key: aboutKey, child: const AboutSection()),

            const Divider(height: 1),

            // 3. Experience Section (Built-in)
            SizedBox(key: experienceKey, child: const _ExperienceSection()),

            // 4. Skills Section (Built-in)
            const _SkillsSection(),

            const SizedBox(height: 60),

            // 5. Projects Carousel (Imported)
            SizedBox(key: projectsKey, child: const ProjectsCarousel()),

            const SizedBox(height: 80),

            // 6. Footer (Imported)
            SizedBox(key: contactKey, child: const FooterSection()),
          ],
        ),
      ),
    );
  }
}

// --- LOCAL WIDGETS ---

class _NavBarItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _NavBarItem({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    // Hidden on small phones, visible on tablets/web
    return MediaQuery.of(context).size.width > 600
        ? TextButton(onPressed: onTap, child: Text(title))
        : const SizedBox.shrink();
  }
}

class _HeroSection extends StatelessWidget {
  final VoidCallback onCtaTap;

  const _HeroSection({required this.onCtaTap});

  Future<void> _downloadCV(BuildContext context) async {
    // 1. Get current language code ('en' or 'fr')
    final String langCode = context.locale.languageCode;

    // 2. Construct the path (ensure files are named cv_en.pdf and cv_fr.pdf)
    final String assetPath = 'assets/cv/Pierre Junior_cv_$langCode.pdf';

    // 3. Open the PDF
    // On Web, this opens it in a new browser tab where they can save it.
    final Uri uri = Uri.parse(assetPath);
    if (!await launchUrl(uri)) {
      debugPrint('Could not launch $uri');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).colorScheme.surface,
            Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.3),
          ],
        ),
      ),
      child: Column(
        children: [
          Text(
            LocaleKeys.hero_title.tr(),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Text(
              LocaleKeys.hero_subtitle.tr(),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                fontSize: MediaQuery.of(context).size.width < 600 ? 32 : 56,
              ),
            ),
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FilledButton.icon(
                onPressed: onCtaTap,
                icon: const Icon(Icons.visibility),
                label: Text(LocaleKeys.hero_cta_view.tr()),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 20,
                  ),
                ),
              ),
              const SizedBox(width: 20),
              OutlinedButton.icon(
                onPressed: () => _downloadCV(context),
                icon: const Icon(Icons.download),
                label: Text("${LocaleKeys.hero_cta_cv.tr()} (${context.locale.languageCode.toUpperCase()})"),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 20,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ExperienceSection extends StatelessWidget {
  const _ExperienceSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      width: double.infinity,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 900),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              LocaleKeys.experience_title.tr(),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 40),
            // Iterating over the workHistory list from data.dart
            ...workHistory.map(
              (job) => Padding(
                padding: const EdgeInsets.only(bottom: 40.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Timeline Line
                    Column(
                      children: [
                        Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        Container(
                          width: 2,
                          height: 200, // Approximate height
                          color: Theme.of(context).colorScheme.outlineVariant,
                        ),
                      ],
                    ),
                    const SizedBox(width: 24),
                    // Content
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            job.role,
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "${job.company}  •  ${job.duration}",
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(color: Colors.grey[700]),
                          ),
                          const SizedBox(height: 16),
                          // Bullet Points
                          ...job.achievements.map(
                            (point) => Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "• ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Expanded(child: Text(point.tr())),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SkillsSection extends StatelessWidget {
  const _SkillsSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Theme.of(context).colorScheme.surfaceContainer,
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
      child: Column(
        children: [
          Text(
            LocaleKeys.sections_skills.tr(),
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 30),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            alignment: WrapAlignment.center,
            children: skills
                .map(
                  (skill) => Chip(
                    avatar: const Icon(Icons.code, size: 16),
                    // Generic code icon
                    label: Text(skill),
                    backgroundColor: Colors.white,
                    side: BorderSide.none,
                    elevation: 2,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 8,
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        // Gradient background for a modern "tech" feel
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.tertiary,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12), // Rounded corners (Squircle)
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.4),
            blurRadius: 8,
            offset: const Offset(2, 4),
          ),
        ],
      ),
      child: Center(
        child: Text(
          "PJ",
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
            fontWeight: FontWeight.w900,
            fontSize: 18,
            letterSpacing: -1.0,
            // Tighter spacing for a logo look
            height: 1.0,
          ),
        ),
      ),
    );
  }
}
