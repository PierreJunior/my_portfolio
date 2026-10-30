import 'package:my_portfolio/lang/locale_keys.g.dart';

class DeveloperProfile {
  static const String name = "Pierre Junior Kahozi";
  static const String title = "Full-Stack Software Developer";
  static const String email = "pierresangwa@gmail.com";
  static const String location = "Lubumbashi, DRC";
  static const String linkedInUrl =
      "https://www.linkedin.com/in/pierre-junior-kahozi-49aa48aa/";

  static const String cvUrlFr =
      "https://drive.google.com/file/d/1M1HvPVF95vHlenm-MSeYFkZ_-N6lK5tb/view?usp=sharing";
  static const String cvUrlEn =
      "https://drive.google.com/file/d/154D8ntJWXlogtrKjmFvLIL24gv6JutDI/view?usp=sharing";

  static String getCvUrl(String languageCode) {
    if (languageCode == 'fr') {
      return cvUrlFr;
    }
    // Default to English for 'en' or any other language
    return cvUrlEn;
  }
}

/// A headline number in the key-facts strip. The value is the same in every
/// language; only the label is translated.
class KeyFact {
  final String value;
  final String labelKey;

  const KeyFact(this.value, this.labelKey);
}

const List<KeyFact> keyFacts = [
  KeyFact("2022", LocaleKeys.facts_since),
  KeyFact("15 → 2 min", LocaleKeys.facts_pipeline),
  KeyFact("90%", LocaleKeys.facts_face_match),
  KeyFact("2 + 1", LocaleKeys.facts_apps),
];

class Experience {
  final String company;
  final String roleKey;
  final String durationKey;
  final List<String> achievementKeys;
  final bool current;

  const Experience({
    required this.company,
    required this.roleKey,
    required this.durationKey,
    required this.achievementKeys,
    this.current = false,
  });
}

const List<Experience> workHistory = [
  Experience(
    company: "Kamoto Copper Company",
    roleKey: LocaleKeys.experience_jobs_kcc_role,
    durationKey: LocaleKeys.experience_jobs_kcc_duration,
    current: true,
    achievementKeys: [
      LocaleKeys.experience_jobs_kcc_items_first,
      LocaleKeys.experience_jobs_kcc_items_second,
      LocaleKeys.experience_jobs_kcc_items_third,
    ],
  ),
  Experience(
    company: "",
    roleKey: LocaleKeys.experience_jobs_upskilling_role,
    durationKey: LocaleKeys.experience_jobs_upskilling_duration,
    achievementKeys: [LocaleKeys.experience_jobs_upskilling_items_first],
  ),
  Experience(
    company: "Akrotech",
    roleKey: LocaleKeys.experience_jobs_akrotech_role,
    durationKey: LocaleKeys.experience_jobs_akrotech_duration,
    achievementKeys: [
      LocaleKeys.experience_jobs_akrotech_items_first,
      LocaleKeys.experience_jobs_akrotech_items_second,
      LocaleKeys.experience_jobs_akrotech_items_third,
    ],
  ),
];

class SkillGroup {
  final String titleKey;
  final List<String> items;

  const SkillGroup(this.titleKey, this.items);
}

const List<SkillGroup> skillGroups = [
  SkillGroup(LocaleKeys.stack_web, [
    "C#",
    "Blazor Server",
    "EF Core",
    "Dapper",
    "MSSQL",
    "REST APIs",
  ]),
  SkillGroup(LocaleKeys.stack_mobile, [
    "Dart",
    "Flutter",
    "Riverpod",
    "Provider",
  ]),
  SkillGroup(LocaleKeys.stack_data, [
    "MSSQL",
    "PostgreSQL",
    "Supabase",
    "Firebase",
    "AWS Rekognition",
    "QuestPDF",
    "ClosedXML",
  ]),
  SkillGroup(LocaleKeys.stack_delivery, [
    "GitHub Actions",
    "Codemagic",
    "Firebase Hosting",
    "Cloudflare Pages",
  ]),
];

/// Where a project stands today. Drives the status chip on cards and the
/// case-study header, so badges never depend on matching translated text.
enum ProjectStatus { live, retired, learning }

/// One box in a case study's architecture diagram. [tierLabel] is the small
/// label (client, state, ...), [name] the technology, [detailKey] the
/// one-line explanation.
class ArchNode {
  final String tierLabel;
  final String name;
  final String detailKey;
  final bool highlight;
  final bool dashed;

  const ArchNode({
    required this.tierLabel,
    required this.name,
    required this.detailKey,
    this.highlight = false,
    this.dashed = false,
  });
}

class Project {
  /// Stable id: used in the URL (`/work/<slug>`) and to build the
  /// translation keys under `projects.<slug>.*`.
  final String slug;
  final ProjectStatus status;

  /// Company the project was built for; shown in the "retired" chip.
  final String? client;
  final String stack;
  final List<String> screenshots;

  /// Screenshot shown on the home-page card and at the top of the case study.
  final String cardImage;
  final String heroImage;

  /// Phone screenshots are tall and get a narrow phone frame on cards.
  final bool phoneShots;
  final String? liveUrl;
  final int featureCount;
  final int decisionCount;
  final List<ArchNode> architecture;

  /// Featured projects get the large card at the top of the work section.
  final bool featured;

  const Project({
    required this.slug,
    required this.status,
    required this.stack,
    required this.screenshots,
    required this.cardImage,
    required this.heroImage,
    required this.architecture,
    this.client,
    this.phoneShots = true,
    this.liveUrl,
    this.featureCount = 4,
    this.decisionCount = 3,
    this.featured = false,
  });

  String key(String path) => 'projects.$slug.$path';

  String get titleKey => key('title');
  String get summaryKey => key('summary');
  String get route => '/work/$slug';

  List<String> get problemKeys => [key('problem.first'), key('problem.second')];

  List<({String title, String body})> get featureKeys => [
    for (var i = 1; i <= featureCount; i++)
      (title: key('features.f${i}_title'), body: key('features.f${i}_body')),
  ];

  List<({String title, String body})> get decisionKeys => [
    for (var i = 1; i <= decisionCount; i++)
      (title: key('decisions.d${i}_title'), body: key('decisions.d${i}_body')),
  ];
}

final List<Project> projects = [
  Project(
    slug: 'kahvent',
    status: ProjectStatus.live,
    featured: true,
    phoneShots: false,
    stack: "Flutter · Supabase · PostgreSQL · Riverpod",
    liveUrl: "https://kahvent.pierrekahozi.com",
    cardImage: "assets/Kahvent_Dashboard.png",
    heroImage: "assets/Kahvent_EventOverview.png",
    screenshots: [
      "assets/Kahvent_Dashboard.png",
      "assets/Kahvent_CreateEvent.png",
      "assets/Kahvent_EventOverview.png",
      "assets/Kahvent_PartiesOverview.png",
      "assets/Kahvent_invitationDetail.png",
      "assets/Kahvent_AddParty.png",
      "assets/Kahvent_ImportParties.png",
      "assets/Kahvent_EventTeam.png",
      "assets/Kahvent_AddEventTeam.png",
      "assets/Kahvent_EventTeamType.png",
      "assets/Kahvent_HaveTeamCode.png",
    ],
    architecture: const [
      ArchNode(
        tierLabel: "CLIENT",
        name: "Flutter",
        detailKey: 'projects.kahvent.arch.client',
      ),
      ArchNode(
        tierLabel: "STATE",
        name: "Riverpod",
        detailKey: 'projects.kahvent.arch.state',
      ),
      ArchNode(
        tierLabel: "BACKEND",
        name: "Supabase",
        detailKey: 'projects.kahvent.arch.backend',
        highlight: true,
      ),
      ArchNode(
        tierLabel: "EDGE",
        name: "Cloudflare Pages",
        detailKey: 'projects.kahvent.arch.edge',
        dashed: true,
      ),
    ],
  ),
  Project(
    slug: 'tahadhari',
    status: ProjectStatus.retired,
    client: "Akrotech",
    stack: "Flutter · Riverpod · Location · FCM · AWS Rekognition",
    cardImage: "assets/tahadhariMap.jpg",
    heroImage: "assets/tahadhariMap.jpg",
    screenshots: [
      "assets/tahadhariLoginScreen.jpg",
      "assets/tahadhariDashboard.jpg",
      "assets/tahadhariAlert.jpg",
      "assets/tahadhariMap.jpg",
      "assets/tahadhariNOK.jpg",
      "assets/tahadhariNOK1.jpg",
    ],
    architecture: const [
      ArchNode(
        tierLabel: "CLIENT",
        name: "Flutter",
        detailKey: 'projects.tahadhari.arch.client',
      ),
      ArchNode(
        tierLabel: "STATE",
        name: "Riverpod",
        detailKey: 'projects.tahadhari.arch.state',
      ),
      ArchNode(
        tierLabel: "PUSH",
        name: "FCM",
        detailKey: 'projects.tahadhari.arch.backend',
        highlight: true,
      ),
      ArchNode(
        tierLabel: "IDENTITY",
        name: "AWS Rekognition",
        detailKey: 'projects.tahadhari.arch.edge',
        dashed: true,
      ),
    ],
  ),
  Project(
    slug: 'rosary',
    status: ProjectStatus.retired,
    client: "Akrotech",
    stack: "Flutter · Firebase · Offline sync · AdMob",
    cardImage: "assets/rosary1.jpg",
    heroImage: "assets/rosary1.jpg",
    screenshots: [
      "assets/rosary1.jpg",
      "assets/rosary2.jpg",
      "assets/rosary3.jpg",
      "assets/rosary4.jpg",
      "assets/rosary5.jpg",
      "assets/rosary6.jpg",
      "assets/rosary7.jpg",
    ],
    architecture: const [
      ArchNode(
        tierLabel: "CLIENT",
        name: "Flutter",
        detailKey: 'projects.rosary.arch.client',
      ),
      ArchNode(
        tierLabel: "CACHE",
        name: "Offline store",
        detailKey: 'projects.rosary.arch.state',
      ),
      ArchNode(
        tierLabel: "SYNC",
        name: "Firestore",
        detailKey: 'projects.rosary.arch.backend',
        highlight: true,
      ),
      ArchNode(
        tierLabel: "ADS",
        name: "AdMob",
        detailKey: 'projects.rosary.arch.edge',
        dashed: true,
      ),
    ],
  ),
  Project(
    slug: 'clima',
    status: ProjectStatus.learning,
    stack: "Flutter · OpenWeatherMap API · Geolocation",
    cardImage: "assets/clima.jpg",
    heroImage: "assets/clima.jpg",
    featureCount: 2,
    decisionCount: 0,
    screenshots: ["assets/clima.jpg", "assets/clima2.jpg", "assets/clima3.jpg"],
    architecture: const [
      ArchNode(
        tierLabel: "CLIENT",
        name: "Flutter",
        detailKey: 'projects.clima.arch.client',
      ),
      ArchNode(
        tierLabel: "DEVICE",
        name: "Geolocation",
        detailKey: 'projects.clima.arch.state',
      ),
      ArchNode(
        tierLabel: "API",
        name: "OpenWeatherMap",
        detailKey: 'projects.clima.arch.backend',
        highlight: true,
      ),
    ],
  ),
];

Project? projectBySlug(String slug) {
  for (final project in projects) {
    if (project.slug == slug) return project;
  }
  return null;
}

/// The project the "Next" link at the bottom of a case study points to.
Project? nextProject(String slug) {
  final i = projects.indexWhere((p) => p.slug == slug);
  if (i == -1) return null;
  return i + 1 < projects.length ? projects[i + 1] : null;
}
