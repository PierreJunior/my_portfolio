import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:my_portfolio/lang/locale_keys.g.dart';
import 'package:my_portfolio/models/data.dart';
import 'package:my_portfolio/theme/app_theme.dart';
import 'package:my_portfolio/widgets/common.dart';

/// Strip of headline numbers that overlaps the bottom of the hero.
class KeyFactsSection extends StatelessWidget {
  const KeyFactsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final mobile = Breakpoints.isMobile(context);
    return Semantics(
      label: LocaleKeys.facts_label.tr(),
      container: true,
      child: PageWidth(
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.border,
            border: Border.all(color: AppColors.border),
            borderRadius: BorderRadius.circular(14),
          ),
          clipBehavior: Clip.antiAlias,
          child: ResponsiveGrid(
            spacing: 1,
            minItemWidth: mobile ? 140 : 220,
            maxColumns: mobile ? 2 : 4,
            children: [
              for (final fact in keyFacts)
                Container(
                  color: AppColors.surface,
                  padding: EdgeInsets.all(mobile ? 16 : 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(fact.value,
                          style: AppFonts.display(size: mobile ? 24 : 34, color: AppColors.accent, letterSpacing: 0)),
                      const SizedBox(height: 6),
                      Text(fact.labelKey.tr(), style: AppFonts.body(size: mobile ? 13 : 14, color: AppColors.textMuted, height: 1.4)),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// "Case studies": the featured project, the other client projects, and a
/// one-line mention of learning projects.
class WorkSection extends StatelessWidget {
  const WorkSection({super.key});

  @override
  Widget build(BuildContext context) {
    final featured = projects.where((p) => p.featured);
    final others = projects.where((p) => !p.featured && p.status != ProjectStatus.learning).toList();
    final learning = projects.where((p) => p.status == ProjectStatus.learning);

    return PageWidth(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SectionHeading(label: LocaleKeys.work_label.tr(), title: LocaleKeys.work_title.tr()),
          const SizedBox(height: 40),
          for (final project in featured) ...[
            FeaturedProjectCard(project: project),
            const SizedBox(height: 24),
          ],
          ResponsiveGrid(
            minItemWidth: 340,
            spacing: 24,
            children: [for (final project in others) ProjectCard(project: project)],
          ),
          for (final project in learning) ...[
            const SizedBox(height: 16),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text('${LocaleKeys.work_also.tr()} ', style: AppFonts.body(size: 14, color: AppColors.textMuted)),
                AppTextLink(label: project.titleKey.tr(), uri: Uri.parse(project.route)),
                Text(LocaleKeys.work_also_rest.tr(), style: AppFonts.body(size: 14, color: AppColors.textMuted)),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class FeaturedProjectCard extends StatelessWidget {
  final Project project;

  const FeaturedProjectCard({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    final mobile = Breakpoints.isMobile(context);
    final image = Container(
      color: AppColors.tint,
      padding: EdgeInsets.all(mobile ? 16 : 32),
      alignment: Alignment.center,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [BoxShadow(color: Color(0x240F1A1A), blurRadius: 40, offset: Offset(0, 12))],
        ),
        child: Screenshot(
          asset: project.cardImage,
          semanticLabel: project.key('shot_card').tr(),
          fit: BoxFit.contain,
        ),
      ),
    );

    final details = Padding(
      padding: EdgeInsets.all(mobile ? 20 : 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(spacing: 8, runSpacing: 8, children: statusPills(project)),
          const SizedBox(height: 20),
          Semantics(
            header: true,
            child: Text(project.titleKey.tr(), style: AppFonts.display(size: mobile ? 24 : 34)),
          ),
          const SizedBox(height: 16),
          Text(project.summaryKey.tr(), style: AppFonts.body(size: mobile ? 15 : 17, color: AppColors.textBody)),
          const SizedBox(height: 20),
          _FactRow(label: LocaleKeys.work_role.tr(), value: project.key('role').tr()),
          _FactRow(label: LocaleKeys.work_platforms.tr(), value: project.key('platforms').tr()),
          _FactRow(label: LocaleKeys.work_stack.tr(), value: project.stack),
          _FactRow(label: LocaleKeys.work_security.tr(), value: project.key('security').tr()),
          const SizedBox(height: 24),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              AppLinkButton(label: LocaleKeys.work_read.tr(), uri: Uri.parse(project.route), expand: mobile),
              if (project.liveUrl != null)
                AppLinkButton(
                  label: LocaleKeys.work_open_live.tr(),
                  uri: Uri.parse(project.liveUrl!),
                  style: AppButtonStyle.outline,
                  newTab: true,
                  expand: mobile,
                ),
            ],
          ),
        ],
      ),
    );

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
      ),
      clipBehavior: Clip.antiAlias,
      child: LayoutBuilder(builder: (context, constraints) {
        if (constraints.maxWidth < 900) {
          return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [image, details]);
        }
        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [Expanded(flex: 3, child: image), Expanded(flex: 2, child: details)],
          ),
        );
      }),
    );
  }
}

class _FactRow extends StatelessWidget {
  final String label;
  final String value;

  const _FactRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 96, child: Text(label, style: AppFonts.body(size: 14, color: AppColors.textMuted, height: 1.5))),
          Expanded(child: Text(value, style: AppFonts.body(size: 14, color: AppColors.ink, height: 1.5))),
        ],
      ),
    );
  }
}

/// Card for a client project: phone screenshot on top, summary below.
class ProjectCard extends StatelessWidget {
  final Project project;

  const ProjectCard({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 220,
            color: AppColors.tint,
            padding: const EdgeInsets.only(top: 24),
            alignment: Alignment.bottomCenter,
            child: Screenshot(
              asset: project.cardImage,
              semanticLabel: project.key('shot_card').tr(),
              width: 120,
              height: 196,
              decodeWidth: 360,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(spacing: 8, runSpacing: 8, children: statusPills(project)),
                  const SizedBox(height: 14),
                  Semantics(header: true, child: Text(project.titleKey.tr(), style: AppFonts.display(size: 26))),
                  const SizedBox(height: 10),
                  Text(project.summaryKey.tr(), style: AppFonts.body(size: 15, color: AppColors.textBody)),
                  const SizedBox(height: 12),
                  Text(project.stack, style: AppFonts.mono(size: 13, weight: FontWeight.w400, color: AppColors.textMuted)),
                  const Spacer(),
                  const SizedBox(height: 12),
                  AppTextLink(label: LocaleKeys.work_read.tr(), uri: Uri.parse(project.route)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
