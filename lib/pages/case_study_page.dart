import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:my_portfolio/lang/locale_keys.g.dart';
import 'package:my_portfolio/models/data.dart';
import 'package:my_portfolio/sections/header_section.dart';
import 'package:my_portfolio/theme/app_theme.dart';
import 'package:my_portfolio/widgets/common.dart';
import 'package:url_launcher/link.dart';

class CaseStudyPage extends StatelessWidget {
  final String slug;

  const CaseStudyPage({super.key, required this.slug});

  @override
  Widget build(BuildContext context) {
    // Rebuild on language change; `.tr()` alone doesn't register one.
    context.locale;
    final project = projectBySlug(slug);
    final mobile = Breakpoints.isMobile(context);
    final allWork = AppTextLink(
      label: LocaleKeys.study_all_work.tr(),
      uri: Uri.parse('/'),
      color: AppColors.onDeepNav,
    );

    if (project == null) {
      return Scaffold(
        backgroundColor: AppColors.deep,
        body: SafeArea(
          child: Column(
            children: [
              NavBar(trailing: allWork),
              Expanded(
                child: Center(
                  child: Text(LocaleKeys.study_not_found.tr(),
                      style: AppFonts.display(size: 28, color: AppColors.onDeep)),
                ),
              ),
            ],
          ),
        ),
      );
    }

    final next = nextProject(slug);
    final gap = mobile ? 56.0 : 80.0;

    return Scaffold(
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
                    NavBar(trailing: allWork),
                    _CaseHeader(project: project),
                  ],
                ),
              ),
            ),
            Transform.translate(
              offset: const Offset(0, -24),
              child: PageWidth(
                child: SurfaceCard(
                  radius: 18,
                  padding: EdgeInsets.all(mobile ? 12 : 24),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: project.phoneShots ? 560 : 900),
                      child: Screenshot(
                        asset: project.heroImage,
                        semanticLabel: project.key('shot_hero').tr(),
                        fit: BoxFit.contain,
                        decodeWidth: 2000,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: gap - 24),
            _CaseRow(
              title: LocaleKeys.study_problem.tr(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (final key in project.problemKeys)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Text(key.tr(), style: AppFonts.body(size: mobile ? 16 : 18, color: AppColors.textBody, height: 1.7)),
                    ),
                ],
              ),
            ),
            SizedBox(height: gap - 16),
            _CaseRow(
              title: LocaleKeys.study_built.tr(),
              child: ResponsiveGrid(
                minItemWidth: 260,
                spacing: 16,
                maxColumns: 2,
                children: [
                  for (final feature in project.featureKeys)
                    SurfaceCard(
                      padding: const EdgeInsets.all(22),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(feature.title.tr(), style: AppFonts.body(weight: FontWeight.w600, color: AppColors.ink)),
                          const SizedBox(height: 8),
                          Text(feature.body.tr(), style: AppFonts.body(size: 15, color: AppColors.textBody)),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(height: gap),
            PageWidth(child: _ArchitectureDiagram(project: project)),
            if (project.decisionKeys.isNotEmpty) ...[
              SizedBox(height: gap),
              PageWidth(child: _Decisions(project: project)),
            ],
            SizedBox(height: gap),
            PageWidth(child: _ScreensStrip(project: project)),
            SizedBox(height: mobile ? 64 : 96),
            PageWidth(
              child: Container(
                padding: EdgeInsets.only(top: 24, bottom: mobile ? 48 : 80),
                decoration: const BoxDecoration(border: Border(top: BorderSide(color: AppColors.border))),
                child: Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  spacing: 16,
                  children: [
                    AppTextLink(label: LocaleKeys.study_back.tr(), uri: Uri.parse('/')),
                    if (next != null)
                      AppTextLink(
                        label: LocaleKeys.study_next.tr(args: [next.titleKey.tr()]),
                        uri: Uri.parse(next.route),
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

class _CaseHeader extends StatelessWidget {
  final Project project;

  const _CaseHeader({required this.project});

  @override
  Widget build(BuildContext context) {
    final mobile = Breakpoints.isMobile(context);
    final statusText = project.key('status').tr();
    final facts = <(String, Widget)>[
      (LocaleKeys.study_role.tr(), _factValue(project.key('role').tr())),
      (LocaleKeys.study_stack.tr(), _factValue(project.stack)),
      (LocaleKeys.study_platforms.tr(), _factValue(project.key('platforms').tr())),
      (
        LocaleKeys.study_status.tr(),
        project.liveUrl == null
            ? _factValue(statusText)
            : Link(
                uri: Uri.parse(project.liveUrl!),
                target: LinkTarget.blank,
                builder: (context, followLink) => InkWell(
                  onTap: followLink,
                  child: Text(statusText, style: AppFonts.body(color: AppColors.accentSoft, height: 1.4)),
                ),
              ),
      ),
    ];

    return PageWidth(
      padding: EdgeInsets.only(top: mobile ? 24 : 56, bottom: mobile ? 56 : 72),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${LocaleKeys.study_label.tr()} · ${project.key('period').tr()}',
              style: AppFonts.mono(color: AppColors.accentSoft)),
          const SizedBox(height: 24),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 900),
            child: Semantics(
              header: true,
              child: Text(
                project.key('headline').tr(),
                style: AppFonts.display(size: mobile ? 36 : 60, color: AppColors.onDeep, height: 1.05, letterSpacing: -0.03),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.only(top: 24),
            decoration: const BoxDecoration(border: Border(top: BorderSide(color: AppColors.deepBorder))),
            child: ResponsiveGrid(
              minItemWidth: 200,
              spacing: 24,
              children: [
                for (final (label, value) in facts)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(label, style: AppFonts.mono(size: 12, color: AppColors.onDeepMuted)),
                      const SizedBox(height: 6),
                      value,
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _factValue(String text) =>
      Text(text, style: AppFonts.body(color: AppColors.onDeep, height: 1.4));
}

/// Heading on the left, content on the right; stacked on phones.
class _CaseRow extends StatelessWidget {
  final String title;
  final Widget child;

  const _CaseRow({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    final mobile = Breakpoints.isMobile(context);
    final heading = Semantics(
      header: true,
      child: Text(title, style: AppFonts.display(size: mobile ? 26 : 32)),
    );
    return PageWidth(
      child: mobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [heading, const SizedBox(height: 20), child],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: 300, child: heading),
                const SizedBox(width: 48),
                Expanded(child: child),
              ],
            ),
    );
  }
}

class _ArchitectureDiagram extends StatelessWidget {
  final Project project;

  const _ArchitectureDiagram({required this.project});

  @override
  Widget build(BuildContext context) {
    final mobile = Breakpoints.isMobile(context);
    final nodes = project.architecture;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Semantics(header: true, child: Text(LocaleKeys.study_architecture.tr(), style: AppFonts.display(size: mobile ? 26 : 32))),
        const SizedBox(height: 28),
        Container(
          padding: EdgeInsets.all(mobile ? 20 : 40),
          decoration: BoxDecoration(color: AppColors.deep, borderRadius: BorderRadius.circular(18)),
          child: Column(
            children: [
              Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 16,
                runSpacing: 16,
                children: [
                  for (var i = 0; i < nodes.length; i++) ...[
                    if (i > 0)
                      ExcludeSemantics(
                        child: Text(mobile ? '↓' : '→',
                            style: AppFonts.mono(size: 20, color: AppColors.onDeepMuted)),
                      ),
                    _ArchBox(node: nodes[i], width: mobile ? double.infinity : 230),
                  ],
                ],
              ),
              const SizedBox(height: 16),
              Text(LocaleKeys.study_diagram_caption.tr(),
                  textAlign: TextAlign.center, style: AppFonts.body(size: 13, color: AppColors.onDeepMuted)),
            ],
          ),
        ),
      ],
    );
  }
}

class _ArchBox extends StatelessWidget {
  final ArchNode node;
  final double width;

  const _ArchBox({required this.node, required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: node.highlight ? AppColors.accent : null,
        borderRadius: BorderRadius.circular(12),
        border: node.highlight
            ? null
            : Border.all(color: node.dashed ? AppColors.deepButtonBorder : AppColors.deepOutline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(node.tierLabel, style: AppFonts.mono(size: 12, color: node.highlight ? const Color(0xFFCCFBF1) : AppColors.accentSoft)),
          const SizedBox(height: 6),
          Text(node.name, style: AppFonts.body(weight: FontWeight.w600, color: AppColors.onDeep, height: 1.3)),
          const SizedBox(height: 4),
          Text(node.detailKey.tr(), style: AppFonts.body(size: 13, color: node.highlight ? const Color(0xFFE6F6F3) : AppColors.onDeepBody, height: 1.5)),
        ],
      ),
    );
  }
}

class _Decisions extends StatelessWidget {
  final Project project;

  const _Decisions({required this.project});

  @override
  Widget build(BuildContext context) {
    final mobile = Breakpoints.isMobile(context);
    final decisions = project.decisionKeys;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Semantics(header: true, child: Text(LocaleKeys.study_decisions.tr(), style: AppFonts.display(size: mobile ? 26 : 32))),
        const SizedBox(height: 28),
        ResponsiveGrid(
          minItemWidth: 300,
          children: [
            for (var i = 0; i < decisions.length; i++)
              SurfaceCard(
                padding: const EdgeInsets.all(26),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${LocaleKeys.study_decision.tr()} ${(i + 1).toString().padLeft(2, '0')}',
                        style: AppFonts.mono(size: 12, color: AppColors.accent)),
                    const SizedBox(height: 10),
                    Semantics(
                      header: true,
                      child: Text(decisions[i].title.tr(), style: AppFonts.body(size: 18, weight: FontWeight.w600, color: AppColors.ink, height: 1.3)),
                    ),
                    const SizedBox(height: 10),
                    Text(decisions[i].body.tr(), style: AppFonts.body(size: 15, color: AppColors.textBody)),
                  ],
                ),
              ),
          ],
        ),
      ],
    );
  }
}

/// Horizontal row of screenshots; tapping one opens a full-screen viewer.
class _ScreensStrip extends StatelessWidget {
  final Project project;

  const _ScreensStrip({required this.project});

  @override
  Widget build(BuildContext context) {
    final shots = project.screenshots;
    final height = project.phoneShots ? 360.0 : 260.0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Semantics(header: true, child: Text(LocaleKeys.study_screens.tr(), style: AppFonts.display(size: Breakpoints.isMobile(context) ? 26 : 32))),
        const SizedBox(height: 24),
        SizedBox(
          height: height,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: shots.length,
            separatorBuilder: (_, _) => const SizedBox(width: 16),
            itemBuilder: (context, index) {
              final label = LocaleKeys.study_screenshot.tr(args: ['${index + 1}', '${shots.length}']);
              return Semantics(
                button: true,
                label: '${project.titleKey.tr()} · $label',
                excludeSemantics: true,
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () => showDialog<void>(
                    context: context,
                    builder: (_) => ScreenshotViewer(project: project, initialIndex: index),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.border),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Screenshot(
                      asset: shots[index],
                      semanticLabel: label,
                      height: height,
                      fit: BoxFit.contain,
                      decodeWidth: project.phoneShots ? 420 : 900,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class ScreenshotViewer extends StatefulWidget {
  final Project project;
  final int initialIndex;

  const ScreenshotViewer({super.key, required this.project, required this.initialIndex});

  @override
  State<ScreenshotViewer> createState() => _ScreenshotViewerState();
}

class _ScreenshotViewerState extends State<ScreenshotViewer> {
  late final PageController _controller = PageController(initialPage: widget.initialIndex);
  late int _index = widget.initialIndex;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _go(int delta) {
    final target = (_index + delta).clamp(0, widget.project.screenshots.length - 1);
    _controller.animateToPage(target, duration: const Duration(milliseconds: 250), curve: Curves.easeOut);
  }

  @override
  Widget build(BuildContext context) {
    final shots = widget.project.screenshots;
    return Dialog.fullscreen(
      backgroundColor: const Color(0xF20B3B3C),
      child: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: shots.length,
            onPageChanged: (i) => setState(() => _index = i),
            itemBuilder: (context, i) => Padding(
              padding: const EdgeInsets.fromLTRB(64, 72, 64, 48),
              child: Screenshot(
                asset: shots[i],
                semanticLabel: LocaleKeys.study_screenshot.tr(args: ['${i + 1}', '${shots.length}']),
                fit: BoxFit.contain,
                alignment: Alignment.center,
                decodeWidth: 2000,
              ),
            ),
          ),
          Positioned(
            top: 16,
            right: 16,
            child: IconButton(
              tooltip: LocaleKeys.study_close.tr(),
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.close, color: AppColors.onDeep),
            ),
          ),
          Positioned(
            top: 28,
            left: 24,
            child: Text('${_index + 1} / ${shots.length}', style: AppFonts.mono(color: AppColors.onDeepNav)),
          ),
          if (_index > 0)
            Positioned(
              left: 8,
              top: 0,
              bottom: 0,
              child: Center(
                child: IconButton(
                  tooltip: LocaleKeys.study_previous_shot.tr(),
                  onPressed: () => _go(-1),
                  icon: const Icon(Icons.chevron_left, color: AppColors.onDeep, size: 36),
                ),
              ),
            ),
          if (_index < shots.length - 1)
            Positioned(
              right: 8,
              top: 0,
              bottom: 0,
              child: Center(
                child: IconButton(
                  tooltip: LocaleKeys.study_next_shot.tr(),
                  onPressed: () => _go(1),
                  icon: const Icon(Icons.chevron_right, color: AppColors.onDeep, size: 36),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
