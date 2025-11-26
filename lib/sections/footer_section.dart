import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:my_portfolio/lang/locale_keys.g.dart';
import 'package:url_launcher/url_launcher.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  // Helper to launch URLs
  Future<void> _launchAction(String urlString) async {
    final Uri uri = Uri.parse(urlString);
    if (!await launchUrl(uri)) {
      debugPrint('Could not launch $uri');
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      color: colorScheme.surfaceContainerHighest, // Slightly darker background
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      child: Column(
        children: [
          Text(
            LocaleKeys.footer_work_together.tr(),
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.primary,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            LocaleKeys.footer_based_in.tr(), //
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 30),

          // Contact Action Buttons
          Wrap(
            spacing: 20,
            runSpacing: 20,
            alignment: WrapAlignment.center,
            children: [
              _ContactButton(
                icon: Icons.email_outlined,
                label: "pierresangwa@gmail.com", //
                onTap: () => _launchAction("mailto:pierresangwa@gmail.com"),
              ),
              _ContactButton(
                icon: Icons.phone_outlined,
                label: "+243 842038115", //
                onTap: () => _launchAction("tel:+243842038115"),
              ),
              _ContactButton(
                icon: Icons.link, // Using link icon for LinkedIn
                label: LocaleKeys.footer_linkedinProfile.tr(), //
                // Replace with your actual LinkedIn URL
                onTap: () => _launchAction("https://www.linkedin.com/in/pierre-junior-kahozi-49aa48aa/"),
              ),
            ],
          ),

          const SizedBox(height: 40),
          const Divider(),
          const SizedBox(height: 20),

          // Copyright
          Text(
            "© ${DateTime.now().year} Pierre Junior. ${LocaleKeys.footer_built_with.tr()}.", //
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}

class _ContactButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ContactButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 20),
      label: Text(label),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        side: BorderSide(color: Theme.of(context).colorScheme.outline),
      ),
    );
  }
}