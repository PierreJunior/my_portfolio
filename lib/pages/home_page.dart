import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:my_portfolio/sections/experience_section.dart';
import 'package:my_portfolio/sections/footer_section.dart';
import 'package:my_portfolio/sections/header_section.dart';
import 'package:my_portfolio/sections/work_section.dart';
import 'package:my_portfolio/theme/app_theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Created once per page, not per build, so scrolling always finds them.
  final _sectionKeys = {for (final section in HomeSection.values) section: GlobalKey()};

  void _scrollTo(HomeSection section) {
    final target = _sectionKeys[section]?.currentContext;
    if (target == null) return;
    Scrollable.ensureVisible(
      target,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Sections translate with `.tr()`, which registers no dependency.
    // Reading the locale here rebuilds the page when the language changes.
    context.locale;
    final mobile = Breakpoints.isMobile(context);
    final sectionGap = mobile ? 64.0 : 112.0;

    return Scaffold(
      endDrawer: mobile ? NavDrawer(onNavigate: _scrollTo) : null,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: AppColors.deep,
              child: SafeArea(
                bottom: false,
                child: Column(
                  children: [
                    NavBar(onNavigate: _scrollTo),
                    HeroSection(onSeeWork: () => _scrollTo(HomeSection.work)),
                  ],
                ),
              ),
            ),
            // The facts strip overlaps the bottom of the dark hero.
            Transform.translate(
              offset: Offset(0, mobile ? -32 : -44),
              child: KeyFactsSection(),
            ),
            SizedBox(height: sectionGap - (mobile ? 32 : 44)),
            KeyedSubtree(key: _sectionKeys[HomeSection.work], child: WorkSection()),
            SizedBox(height: sectionGap),
            KeyedSubtree(key: _sectionKeys[HomeSection.experience], child: ExperienceSection()),
            SizedBox(height: sectionGap),
            KeyedSubtree(key: _sectionKeys[HomeSection.stack], child: StackSection()),
            SizedBox(height: sectionGap),
            KeyedSubtree(key: _sectionKeys[HomeSection.contact], child: FooterSection()),
          ],
        ),
      ),
    );
  }
}
