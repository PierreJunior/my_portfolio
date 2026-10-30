import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:my_portfolio/lang/locale_keys.g.dart';
import 'package:my_portfolio/models/data.dart';
import 'package:my_portfolio/sections/header_section.dart';
import 'package:my_portfolio/theme/app_theme.dart';
import 'package:my_portfolio/widgets/common.dart';

/// Dark contact footer: pitch, email, LinkedIn and CV links.
class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final mobile = Breakpoints.isMobile(context);
    final links = [
      AppLinkButton(
        label: mobile ? LocaleKeys.contact_email.tr() : DeveloperProfile.email,
        uri: Uri(scheme: 'mailto', path: DeveloperProfile.email),
        style: AppButtonStyle.brightOnDark,
        expand: mobile,
      ),
      AppLinkButton(
        label: LocaleKeys.contact_linkedin.tr(),
        uri: Uri.parse(DeveloperProfile.linkedInUrl),
        style: AppButtonStyle.outlineOnDark,
        newTab: true,
        expand: mobile,
      ),
      AppLinkButton(
        label: LocaleKeys.contact_cv.tr(),
        uri: Uri.parse(cvUrlFor(context)),
        style: AppButtonStyle.outlineOnDark,
        newTab: true,
        expand: mobile,
      ),
    ];

    final pitch = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(LocaleKeys.contact_label.tr(), style: AppFonts.mono(color: AppColors.accentSoft)),
        const SizedBox(height: 16),
        Semantics(
          header: true,
          child: Text(
            LocaleKeys.contact_title.tr(),
            style: AppFonts.display(size: mobile ? 34 : 52, color: AppColors.onDeep, height: 1.05),
          ),
        ),
        const SizedBox(height: 16),
        Text(LocaleKeys.contact_subtitle.tr(), style: AppFonts.body(size: 17, color: AppColors.onDeepBody)),
      ],
    );

    return Container(
      color: AppColors.deep,
      child: PageWidth(
        padding: EdgeInsets.only(top: mobile ? 56 : 88, bottom: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (mobile) ...[
              pitch,
              const SizedBox(height: 24),
              for (final link in links) ...[link, const SizedBox(height: 10)],
            ] else
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 640), child: pitch)),
                  const SizedBox(width: 32),
                  Wrap(spacing: 12, runSpacing: 12, children: links),
                ],
              ),
            SizedBox(height: mobile ? 32 : 56),
            Container(
              padding: const EdgeInsets.only(top: 24),
              decoration: const BoxDecoration(border: Border(top: BorderSide(color: AppColors.deepBorder))),
              child: Wrap(
                alignment: WrapAlignment.spaceBetween,
                spacing: 16,
                runSpacing: 8,
                children: [
                  Text('© ${DateTime.now().year} ${DeveloperProfile.name}',
                      style: AppFonts.mono(size: 13, weight: FontWeight.w400, color: AppColors.onDeepMuted)),
                  Text(LocaleKeys.contact_built_with.tr(),
                      style: AppFonts.mono(size: 13, weight: FontWeight.w400, color: AppColors.onDeepMuted)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
