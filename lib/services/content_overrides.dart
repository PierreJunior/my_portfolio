import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

/// A single work-experience entry as edited live in Firestore.
/// Unlike [Experience] in `models/data.dart`, achievements here are plain
/// strings (typed directly into Firestore), not translation keys.
class ExperienceOverride {
  final String company;
  final String role;
  final String duration;
  final List<String> achievements;

  const ExperienceOverride({
    required this.company,
    required this.role,
    required this.duration,
    required this.achievements,
  });

  factory ExperienceOverride.fromMap(Map<String, dynamic> map) {
    return ExperienceOverride(
      company: map['company'] as String? ?? '',
      role: map['role'] as String? ?? '',
      duration: map['duration'] as String? ?? '',
      achievements: (map['achievements'] as List<dynamic>? ?? [])
          .map((e) => e.toString())
          .toList(),
    );
  }
}

/// Live content pulled from Firestore for the active locale. Every field is
/// nullable and optional: whatever isn't set in Firestore simply falls back
/// to the bundled `assets/translations/*.json` copy, so the site works
/// identically even if Firestore is empty, unreachable, or not yet seeded.
class ContentOverrides {
  final String? heroTitle;
  final String? heroSubtitle;
  final String? aboutSummary;
  final List<String>? skills;
  final List<ExperienceOverride>? experience;
  final String? cvUrl;

  const ContentOverrides({
    this.heroTitle,
    this.heroSubtitle,
    this.aboutSummary,
    this.skills,
    this.experience,
    this.cvUrl,
  });

  static const empty = ContentOverrides();
}

/// Global, app-wide holder for the currently loaded overrides. Widgets read
/// this via [ValueListenableBuilder] and rebuild once Firestore responds.
final ValueNotifier<ContentOverrides> contentOverrides = ValueNotifier(
  ContentOverrides.empty,
);

String? _loadedForLocale;

/// Fetches `portfolioContent/{localeCode}` from Firestore and publishes it
/// through [contentOverrides]. Safe to call repeatedly — it no-ops if the
/// given locale was already loaded, and silently keeps the bundled content
/// on any failure (offline, doc missing, Firestore not reachable yet).
Future<void> loadContentOverrides(String localeCode) async {
  if (_loadedForLocale == localeCode) return;

  try {
    final snapshot = await FirebaseFirestore.instance
        .collection('portfolioContent')
        .doc(localeCode)
        .get()
        .timeout(const Duration(seconds: 5));

    final data = snapshot.data();
    contentOverrides.value = data == null
        ? ContentOverrides.empty
        : ContentOverrides(
            heroTitle: data['heroTitle'] as String?,
            heroSubtitle: data['heroSubtitle'] as String?,
            aboutSummary: data['aboutSummary'] as String?,
            skills: (data['skills'] as List<dynamic>?)
                ?.map((e) => e.toString())
                .toList(),
            experience: (data['experience'] as List<dynamic>?)
                ?.map(
                  (e) => ExperienceOverride.fromMap(
                    Map<String, dynamic>.from(e as Map),
                  ),
                )
                .toList(),
            cvUrl: data['cvUrl'] as String?,
          );
    _loadedForLocale = localeCode;
  } catch (_) {
    contentOverrides.value = ContentOverrides.empty;
  }
}
