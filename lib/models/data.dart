import 'package:my_portfolio/lang/locale_keys.g.dart'; // Ensure this path matches your generated file

class DeveloperProfile {
  static const String name = "Pierre Junior";
  static const String title = "Flutter Developer";
  static const String email = "pierresangwa@gmail.com";
  static const String phone = "+243 842038115";
  static const String location = "Lubumbashi, DRC";

  // JUST THE KEY
  static final String summary = LocaleKeys.about_summary;
}

class Experience {
  final String company;
  final String role;
  final String duration;
  final List<String> achievements;

  Experience(this.company, this.role, this.duration, this.achievements);
}

final List<Experience> workHistory = [
  Experience(
      "Akrotech",
      "Junior Software Developer",
      "Sept 2022 - Dec 2024",
      [
        // JUST THE KEYS
        LocaleKeys.experience_jobs_akrotech_items_first,
        LocaleKeys.experience_jobs_akrotech_items_second,
        LocaleKeys.experience_jobs_akrotech_items_third,
        LocaleKeys.experience_jobs_akrotech_items_fourth,
        LocaleKeys.experience_jobs_akrotech_items_fifth,
      ]
  ),
];

class Project {
  final String title;
  final String description;
  final String techStack;
  final List<String> screenshots;
  final String? link;

  Project({
    required this.title,
    required this.description,
    required this.techStack,
    required this.screenshots,
    this.link
  });
}

final List<Project> projects = [
  Project(
      title: LocaleKeys.projects_rosary_title, // JUST THE KEY
      description: LocaleKeys.projects_rosary_description, // JUST THE KEY
      techStack: "Flutter, Firebase, Google Admob",
      link: "https://play.google.com/apps/test/RQIualavXRc/...",
      screenshots: [
        "assets/rosaryLogo.jpg",
        "assets/rosary1.jpg",
        "assets/rosary2.jpg",
        "assets/rosary3.jpg",
        "assets/rosary4.jpg",
        "assets/rosary5.jpg",
        "assets/rosary6.jpg",
        "assets/rosary7.jpg",
      ]
  ),
  Project(
      title: LocaleKeys.projects_tahadhari_title, // JUST THE KEY
      description: LocaleKeys.projects_tahadhari_description, // JUST THE KEY
      techStack: "Flutter, Location Services, Push Notifications",
      link: null,
      screenshots: [
        "assets/tahadhariLogo.jpg",
        "assets/tahadhariNOK.jpg",
        "assets/tahadhariNOK1.jpg",
        "assets/tahadhariMap.jpg",
      ]
  ),
  Project(
      title: LocaleKeys.projects_clima_title, // JUST THE KEY
      description: LocaleKeys.projects_clima_description, // JUST THE KEY
      techStack: "Flutter, OpenWeatherMapAPI, Geolocation",
      link: null,
      screenshots: [
        "assets/clima.jpg",
        "assets/clima2.jpg",
        "assets/clima3.jpg",
      ]
  ),
];

final List<String> skills = [
  "Dart & C#",
  "Flutter & Firebase",
  "Riverpod & Provider",
  "CI/CD (GitHub Actions)",
  "RESTful APIs & SQL",
  "Unit & Integration Testing",
];