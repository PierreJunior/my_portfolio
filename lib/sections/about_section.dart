import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:my_portfolio/lang/locale_keys.g.dart';
import 'package:my_portfolio/models/data.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
      color: Theme.of(context).colorScheme.surface, // Clean background
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Responsive Switch:
          // Width > 800px: Row (Side by side)
          // Width < 800px: Column (Stacked)
          if (constraints.maxWidth > 800) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 2, child: _buildProfileImage(context)),
                const SizedBox(width: 40),
                Expanded(flex: 3, child: _buildTextContent(context)),
              ],
            );
          } else {
            return Column(
              children: [
                _buildProfileImage(context),
                const SizedBox(height: 30),
                _buildTextContent(context),
              ],
            );
          }
        },
      ),
    );
  }

  // 1. Profile Image Placeholder
  Widget _buildProfileImage(BuildContext context) {
    return Center(
      child: Container(
        width: 250,
        height: 250,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).colorScheme.primaryContainer,
          image: const DecorationImage(
            image: AssetImage('assets/profile.jpg'),
            fit: BoxFit.cover,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
      ),
    );
  }

  // 2. Text Content (Summary + Education)
  Widget _buildTextContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.about_title.tr(),
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(height: 16),

        // Professional Summary
        Text(
          DeveloperProfile.summary.tr(),
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            height: 1.6,
            fontSize: 18,
          ),
        ),

        const SizedBox(height: 30),
        const Divider(),
        const SizedBox(height: 30),

        // Education Subsection
        _buildInfoRow(
            context,
            Icons.school_outlined,
            LocaleKeys.about_education_title.tr(),
            "National Diploma in Business Information Technology\nUniversity of Johannesburg (Jan 2017 - Dec 2022)"
        ),

        const SizedBox(height: 20),

        // Certifications Subsection
        _buildInfoRow(
            context,
            Icons.verified_outlined,
            LocaleKeys.about_cert_title.tr(),
            "The Complete Flutter Development Bootcamp with Dart\nUdemy (Sept 2022)"
        ),
      ],
    );
  }

  Widget _buildInfoRow(BuildContext context, IconData icon, String title, String content) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: Theme.of(context).colorScheme.primary),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                content,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[700],
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}