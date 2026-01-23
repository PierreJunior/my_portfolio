import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:my_portfolio/lang/locale_keys.g.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
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
  void _scrollToSection(GlobalKey key, {BuildContext? context}) {
    // If we are in a drawer (context provided), close it first
    if (context != null) {
      Navigator.pop(context);
    }

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

    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        // Check if we are on a mobile screen (width < 600 is a safe bet)
        final isMobile = MediaQuery.of(context).size.width < 800;

        return Scaffold(
          // 1. ADD THE DRAWER
          // Only attach the drawer property if we are on mobile.
          // This prevents the "swipe from left" gesture on desktop.
          drawer: isMobile
              ? _MobileDrawer(
            onAboutTap: () => _scrollToSection(aboutKey, context: context),
            onExpTap: () => _scrollToSection(experienceKey, context: context),
            onProjectsTap: () => _scrollToSection(projectsKey, context: context),
            onContactTap: () => _scrollToSection(contactKey, context: context),
          )
              : null,

          appBar: AppBar(
            backgroundColor: Colors.white.withValues(alpha: 0.95),
            surfaceTintColor: Colors.transparent,
            elevation: 0,
            centerTitle: false, // Keeps logo on the left

            // 2. CONTROL THE HAMBURGER ICON
            // If desktop, hide the default drawer icon. If mobile, let it show.
            automaticallyImplyLeading: isMobile,

            title: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const LogoWidget(),
                  // Responsive Title: Hide text on very small screens to avoid overflow
                  if (MediaQuery.of(context).size.width > 380) ...[
                    SizedBox(width: 2.w),
                    Text(
                      "Pierre Junior",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            actions: [
              // 3. DESKTOP NAVIGATION
              // If NOT mobile, show the standard Row of text buttons
              if (!isMobile) ...[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButton(
                    value: context.supportedLocales.contains(context.locale)
                        ? context.locale
                        : const Locale('en'),
                    underline: const SizedBox(), // Removes the line
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
              ]
              // If IS mobile, show nothing here (the Hamburger is on the left)
              else
                const SizedBox.shrink(),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                // Wrapped the Hero Section CTA in a safe way for mobile
                _HeroSection(onCtaTap: () => _scrollToSection(projectsKey)),
                SizedBox(key: aboutKey, child: const AboutSection()),
                Divider(height: 1.h),
                SizedBox(key: experienceKey, child: const _ExperienceSection()),
                const _SkillsSection(),
                const SizedBox(height: 60),
                SizedBox(key: projectsKey, child: const ProjectsCarousel()),
                const SizedBox(height: 80),
                SizedBox(key: contactKey, child: const FooterSection()),
              ],
            ),
          ),
        );
      },
    );
  }
}

// --- NEW WIDGET: The Mobile Drawer ---

class _MobileDrawer extends StatelessWidget {
  final VoidCallback onAboutTap;
  final VoidCallback onExpTap;
  final VoidCallback onProjectsTap;
  final VoidCallback onContactTap;

  const _MobileDrawer({
    required this.onAboutTap,
    required this.onExpTap,
    required this.onProjectsTap,
    required this.onContactTap,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        children: [
          // Drawer Header
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.3),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const LogoWidget(),
                  const SizedBox(height: 10),
                  Text(
                    "Pierre Junior",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Navigation Links
          ListTile(
            leading: const Icon(Icons.person),
            title: Text(LocaleKeys.nav_about.tr()),
            onTap: onAboutTap,
          ),
          ListTile(
            leading: const Icon(Icons.work),
            title: Text(LocaleKeys.nav_experience.tr()),
            onTap: onExpTap,
          ),
          ListTile(
            leading: const Icon(Icons.code),
            title: Text(LocaleKeys.nav_projects.tr()),
            onTap: onProjectsTap,
          ),

          const Spacer(), // Pushes content to bottom

          // Language Switcher in Drawer
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Language:"),
                DropdownButton(
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
              ],
            ),
          ),

          const Divider(),

          // Contact Button
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: onContactTap,
                icon: const Icon(Icons.mail),
                label: Text(LocaleKeys.nav_contact.tr()),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
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
    // 1. Get the current language code from easy_localization's context
    final currentLanguageCode = context.locale.languageCode;

    // 2. Get the correct CV URL using the helper function from DeveloperProfile
    final urlString = DeveloperProfile.getCvUrl(currentLanguageCode);
    final url = Uri.parse(urlString);

    // 3. Launch the URL if possible, otherwise show an error
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      // Use ScaffoldMessenger to show a small notification at the bottom
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (BuildContext dialogContext) {
            return AlertDialog.adaptive(
              title: Text(LocaleKeys.cv_download_error_title.tr()),
              content: Text(LocaleKeys.cv_download_error_message.tr()),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(dialogContext).pop();
                  },
                  child: Text(LocaleKeys.cv_download_error_close.tr()),
                ),
              ],
            );
          },
        );
      }
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
            Theme.of(
              context,
            ).colorScheme.primaryContainer.withValues(alpha: 0.3),
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
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 20, // Horizontal space
            runSpacing: 20, // Vertical space when wrapped
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
                label: Text(
                  "${LocaleKeys.hero_cta_cv.tr()} (${context.locale.languageCode.toUpperCase()})",
                ),
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
