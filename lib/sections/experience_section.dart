import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:my_portfolio/lang/locale_keys.g.dart';
import 'package:my_portfolio/models/data.dart';
import 'package:my_portfolio/services/content_overrides.dart';
import 'package:my_portfolio/theme/app_theme.dart';
import 'package:my_portfolio/widgets/common.dart';

typedef _Job = ({String title, String duration, List<String> achievements, bool current});

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final mobile = Breakpoints.isMobile(context);
    return ValueListenableBuilder<ContentOverrides>(
      valueListenable: contentOverrides,
      builder: (context, overrides, _) {
        // Firestore overrides hold raw text; the bundled history holds
        // translation keys that still need `.tr()`.
        final List<_Job> jobs = overrides.experience != null
            ? [
                for (final job in overrides.experience!)
                  (
                    title: job.company.isEmpty ? job.role : '${job.role} · ${job.company}',
                    duration: job.duration,
                    achievements: job.achievements,
                    current: false,
                  ),
              ]
            : [
                for (final job in workHistory)
                  (
                    title: job.company.isEmpty ? job.roleKey.tr() : '${job.roleKey.tr()} · ${job.company}',
                    duration: job.durationKey.tr(),
                    achievements: [for (final key in job.achievementKeys) key.tr()],
                    current: job.current,
                  ),
              ];

        final heading = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeading(label: LocaleKeys.experience_label.tr(), title: LocaleKeys.experience_title.tr()),
            const SizedBox(height: 12),
            Text(LocaleKeys.experience_education.tr(), style: AppFonts.body(size: 15, color: AppColors.textBody)),
          ],
        );

        final timeline = Container(
          decoration: const BoxDecoration(
            border: Border(left: BorderSide(color: AppColors.accentTimeline, width: 2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var i = 0; i < jobs.length; i++)
                Padding(
                  padding: EdgeInsets.only(left: mobile ? 20 : 32, bottom: i == jobs.length - 1 ? 0 : 40),
                  child: _JobEntry(job: jobs[i], mobile: mobile),
                ),
            ],
          ),
        );

        return PageWidth(
          child: mobile
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [heading, const SizedBox(height: 28), timeline],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: 320, child: heading),
                    const SizedBox(width: 48),
                    Expanded(child: timeline),
                  ],
                ),
        );
      },
    );
  }
}

class _JobEntry extends StatelessWidget {
  final _Job job;
  final bool mobile;

  const _JobEntry({required this.job, required this.mobile});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(job.duration,
            style: AppFonts.mono(color: job.current ? AppColors.accent : AppColors.textMuted)),
        const SizedBox(height: 8),
        Semantics(
          header: true,
          child: Text(job.title, style: AppFonts.body(size: mobile ? 17 : 22, weight: FontWeight.w600, color: AppColors.ink, height: 1.3)),
        ),
        const SizedBox(height: 10),
        for (final point in job.achievements)
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ExcludeSemantics(child: Text('•  ', style: AppFonts.body(size: 15, color: AppColors.textBody))),
                Expanded(child: Text(point, style: AppFonts.body(size: mobile ? 14 : 15, color: AppColors.textBody))),
              ],
            ),
          ),
      ],
    );
  }
}

class StackSection extends StatelessWidget {
  const StackSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ContentOverrides>(
      valueListenable: contentOverrides,
      builder: (context, overrides, _) {
        // A flat Firestore skills list has no groups, so it shows as one card.
        final groups = overrides.skills != null
            ? [(title: LocaleKeys.stack_title.tr(), items: overrides.skills!)]
            : [for (final group in skillGroups) (title: group.titleKey.tr(), items: group.items)];

        return PageWidth(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SectionHeading(label: LocaleKeys.stack_label.tr(), title: LocaleKeys.stack_title.tr()),
              const SizedBox(height: 32),
              ResponsiveGrid(
                minItemWidth: 220,
                children: [
                  for (final group in groups)
                    SurfaceCard(
                      topAccent: AppColors.accentBright,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Semantics(
                            header: true,
                            child: Text(group.title, style: AppFonts.body(size: 16, weight: FontWeight.w600, color: AppColors.ink)),
                          ),
                          const SizedBox(height: 12),
                          Text(group.items.join(' · '),
                              style: AppFonts.mono(size: 14, weight: FontWeight.w400, color: AppColors.textBody, height: 1.8)),
                        ],
                      ),
                    ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
