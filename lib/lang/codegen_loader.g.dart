// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes, avoid_renaming_method_parameters, constant_identifier_names

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> _en = {
  "nav": {
    "about": "About",
    "experience": "Experience",
    "projects": "Projects",
    "contact": "Contact Me"
  },
  "hero": {
    "title": "Building Scalable Mobile Experiences",
    "subtitle": "Hi, I'm Pierre. A Flutter Developer specializing in performance optimization and clean architecture.",
    "cta_view": "View My Work",
    "cta_cv": "Download CV"
  },
  "about": {
    "title": "About Me",
    "summary": "Highly skilled Flutter Developer with 2+ years of experience in delivering high-performance, scalable mobile applications, consistently improving app performance by 10-15%.",
    "education_title": "Education",
    "cert_title": "Certifications"
  },
  "experience": {
    "title": "Work Experience",
    "jobs": {
      "akrotech": {
        "role": "Junior Software Developer",
        "company": "Akrotech",
        "duration": "Sept 2022 - Dec 2024",
        "items": {
          "first": "Collaborated within a 2-person Flutter development team, partnering with designers to deliver high-quality mobile applications.",
          "second": "Utilized Riverpod for efficient state management, reducing bugs by 15% and improving performance by 100ms.",
          "third": "Integrated AWS Rekognition API for real-time object detection during the profile picture staging process.",
          "fourth": "Automated a continuous code quality workflow via GitHub Actions (Dart Analyzer/Linting).",
          "fifth": "Collaborated with cross-functional teams to accelerate release cycles from weeks to 1-2 days."
        }
      }
    }
  },
  "sections": {
    "experience": "Work Experience",
    "featured_projects": "Featured Projects",
    "skills": "Technical Skills"
  },
  "footer": {
    "work_together": "Let's Work Together",
    "based_in": "Based in Lubumbashi, DRC. Available for remote & hybrid roles.",
    "built_with": "Built with Flutter"
  },
  "projects": {
    "rosary": {
      "title": "Rosary App",
      "description": "A responsive prayer-tracking application with dynamic day-based content rendering. Integrated ad services for monetization."
    },
    "tahadhari": {
      "title": "Tahadhari App",
      "description": "An emergency alert application featuring real-time response capabilities, location services, and push notification systems."
    },
    "clima": {
      "title": "Clima",
      "description": "Weather mobile application to provide current weather information for the user's current location."
    }
  },
  "buttons": {
    "gallery": "Gallery",
    "download_visit": "Download / Visit",
    "view_gallery": "View Gallery",
    "view_details": "View Details"
  }
};
static const Map<String,dynamic> _fr = {
  "nav": {
    "about": "À propos",
    "experience": "Expérience",
    "projects": "Projets",
    "contact": "Contactez-moi"
  },
  "hero": {
    "title": "Création d'expériences mobiles évolutives",
    "subtitle": "Bonjour, je suis Pierre. Développeur Flutter spécialisé dans l'optimisation des performances et l'architecture propre.",
    "cta_view": "Voir mon travail",
    "cta_cv": "Télécharger CV"
  },
  "about": {
    "title": "À propos de moi",
    "summary": "Développeur Flutter hautement qualifié avec plus de 2 ans d'expérience dans la livraison d'applications mobiles performantes et évolutives, améliorant constamment les performances de 10 à 15 %.",
    "education_title": "Éducation",
    "cert_title": "Certifications"
  },
  "experience": {
    "title": "Expérience Professionnelle",
    "jobs": {
      "akrotech": {
        "role": "Développeur Logiciel Junior",
        "company": "Akrotech",
        "duration": "Sept 2022 - Déc 2024",
        "items": {
          "first": "Collaboration au sein d'une équipe Flutter de 2 personnes pour livrer des applications mobiles de haute qualité.",
          "second": "Utilisation de Riverpod pour la gestion d'état, réduisant les bugs de 15 % et améliorant la performance de 100ms.",
          "third": "Intégration de l'API AWS Rekognition pour la détection d'objets en temps réel.",
          "fourth": "Automatisation du flux de qualité de code via GitHub Actions (Dart Analyzer).",
          "fifth": "Accélération des cycles de publication de plusieurs semaines à 1-2 jours grâce aux pipelines CI/CD."
        }
      }
    }
  },
  "sections": {
    "experience": "Expérience Professionnelle",
    "featured_projects": "Projets en Vedette",
    "skills": "Compétences Techniques"
  },
  "footer": {
    "work_together": "Travaillons Ensemble",
    "based_in": "Basé à Lubumbashi, RDC. Disponible pour des postes à distance et hybrides.",
    "built_with": "Construit avec Flutter"
  },
  "projects": {
    "rosary": {
      "title": "Application Rosary",
      "description": "Une application de suivi de prière réactive avec un rendu de contenu dynamique basé sur le jour. Intégration de services publicitaires pour la monétisation."
    },
    "tahadhari": {
      "title": "Application Tahadhari",
      "description": "Une application d'alerte d'urgence dotée de capacités de réponse en temps réel, de services de localisation et de notifications push."
    },
    "clima": {
      "title": "Clima",
      "description": "Application mobile météo fournissant des informations météorologiques actuelles pour la position de l'utilisateur."
    }
  },
  "buttons": {
    "gallery": "Galerie",
    "download_visit": "Télécharger / Visiter",
    "view_gallery": "Voir la galerie",
    "view_details": "Voir détails"
  }
};
static const Map<String, Map<String,dynamic>> mapLocales = {"en": _en, "fr": _fr};
}
