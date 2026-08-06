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
    "title": "Building Scalable Web & Mobile Experiences",
    "subtitle": "Hi, I'm Pierre. A results-driven Full-Stack Software Developer building enterprise web applications (Blazor Server, C#) and scalable cross-platform mobile apps (Flutter), with a strong emphasis on Clean Architecture and user-centric UI/UX.",
    "cta_view": "View My Work",
    "cta_cv": "Download CV"
  },
  "about": {
    "title": "About Me",
    "summary": "Full-Stack Software Developer specializing in enterprise web applications (Blazor Server, C#, EF Core/Dapper) and cross-platform mobile development (Flutter, Dart, Riverpod). Applies Clean Architecture principles to build maintainable, scalable software, with a track record of high-performance data access layers, dynamic PDF/Excel reporting engines, and streamlined CI/CD pipelines.",
    "education_title": "Education",
    "cert_title": "Certifications"
  },
  "experience": {
    "title": "Work Experience",
    "jobs": {
      "kcc": {
        "role": "Full-Stack Developer Intern",
        "company": "KCC",
        "duration": "Feb 2026 - Present",
        "items": {
          "first": "Architected and developed APCMS, an enterprise security operations contract management system built on Blazor Server following layered Clean Architecture principles.",
          "second": "Engineered a high-performance dual-ORM data access layer using EF Core for schema migrations and Dapper for latency-sensitive MSSQL queries.",
          "third": "Implemented a decoupled handler/registry pattern to centralize resource-type rendering, audit logging, and UI status indicators.",
          "fourth": "Delivered enterprise reporting capabilities by integrating QuestPDF for multi-page PDF generation and ClosedXML with row-streaming for reliable Excel import/export.",
          "fifth": "Built dynamic MudBlazor multi-step contract creation forms with per-step validation alongside an interactive management dashboard using Chart.js via JavaScript Interop."
        }
      },
      "independent": {
        "role": "Independent Software Developer & Upskilling",
        "company": "Self-Directed",
        "duration": "Jan 2025 - Jan 2026",
        "items": {
          "first": "Conducted targeted technical research and upskilling in enterprise .NET design patterns, Blazor Server architecture, and advanced SQL query performance tuning.",
          "second": "Engaged in independent technical project design and skill consolidation to drive proactive software engineering career growth."
        }
      },
      "akrotech": {
        "role": "Junior Software Developer",
        "company": "Akrotech",
        "duration": "Sept 2022 - Dec 2024",
        "items": {
          "first": "Developed mobile applications in Flutter and Dart, collaborating with UI/UX designers to translate design mockups into responsive, accessible cross-platform interfaces.",
          "second": "Engineered and deployed production mobile solutions, including the Tahadhari App (Emergency Alert System) and Rosary App (Prayer Tracker with Firebase sync and offline support).",
          "third": "Integrated the AWS Rekognition API during user registration, enforcing a 90% minimum confidence threshold for automated face verification.",
          "fourth": "Applied Riverpod for predictable state management and built resilient RESTful API integration layers with structured error and offline handling.",
          "fifth": "Configured CI/CD deployment automation using GitHub Actions and Codemagic, reducing manual release pipeline execution time from 15 minutes to under 2 minutes."
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
    "built_with": "Built with Flutter",
    "linkedinProfile": "LinkedIn Profile"
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
  },
  "cannot_open_cv": "Could not open CV. Please try again later.",
  "cv_download_error_title": "Download Error",
  "cv_download_error_message": "Could not open the CV. The link may be broken or temporarily unavailable.",
  "cv_download_error_close": "Close"
};
static const Map<String,dynamic> _fr = {
  "nav": {
    "about": "À propos",
    "experience": "Expérience",
    "projects": "Projets",
    "contact": "Contactez-moi"
  },
  "hero": {
    "title": "Création d'expériences web et mobiles évolutives",
    "subtitle": "Bonjour, je suis Pierre. Développeur Full-Stack axé sur les résultats, spécialisé dans les applications web d'entreprise (Blazor Server, C#) et les applications mobiles multiplateformes évolutives (Flutter), avec un accent fort sur la Clean Architecture et l'UI/UX centrée sur l'utilisateur.",
    "cta_view": "Voir mon travail",
    "cta_cv": "Télécharger CV"
  },
  "about": {
    "title": "À propos de moi",
    "summary": "Développeur Full-Stack spécialisé dans les applications web d'entreprise (Blazor Server, C#, EF Core/Dapper) et le développement mobile multiplateforme (Flutter, Dart, Riverpod). Applique les principes de Clean Architecture pour créer des logiciels maintenables et évolutifs, avec un historique de couches d'accès aux données haute performance, de moteurs de reporting PDF/Excel dynamiques et de pipelines CI/CD optimisés.",
    "education_title": "Éducation",
    "cert_title": "Certifications"
  },
  "experience": {
    "title": "Expérience Professionnelle",
    "jobs": {
      "kcc": {
        "role": "Développeur Full-Stack Stagiaire",
        "company": "KCC",
        "duration": "Fév 2026 - Présent",
        "items": {
          "first": "Conception et développement d'APCMS, un système de gestion de contrats pour opérations de sécurité d'entreprise, construit sur Blazor Server selon les principes de la Clean Architecture en couches.",
          "second": "Conception d'une couche d'accès aux données double-ORM haute performance, utilisant EF Core pour les migrations de schéma et Dapper pour les requêtes MSSQL sensibles à la latence.",
          "third": "Mise en œuvre d'un pattern handler/registry découplé pour centraliser le rendu par type de ressource, la journalisation d'audit et les indicateurs de statut UI.",
          "fourth": "Livraison de fonctionnalités de reporting d'entreprise en intégrant QuestPDF pour la génération de PDF multi-pages et ClosedXML avec streaming de lignes pour l'import/export Excel.",
          "fifth": "Création de formulaires MudBlazor dynamiques en plusieurs étapes avec validation par étape, ainsi qu'un tableau de bord interactif utilisant Chart.js via JavaScript Interop."
        }
      },
      "independent": {
        "role": "Développeur Logiciel Indépendant & Perfectionnement",
        "company": "Auto-Formation",
        "duration": "Jan 2025 - Jan 2026",
        "items": {
          "first": "Recherche technique ciblée et perfectionnement sur les design patterns .NET d'entreprise, l'architecture Blazor Server et l'optimisation avancée des requêtes SQL.",
          "second": "Conception de projets techniques indépendants et consolidation des compétences pour une progression de carrière proactive."
        }
      },
      "akrotech": {
        "role": "Développeur Logiciel Junior",
        "company": "Akrotech",
        "duration": "Sept 2022 - Déc 2024",
        "items": {
          "first": "Développement d'applications mobiles en Flutter et Dart, en collaboration avec des designers UI/UX pour traduire des maquettes en interfaces multiplateformes réactives et accessibles.",
          "second": "Conception et déploiement de solutions mobiles en production, dont l'application Tahadhari (système d'alerte d'urgence) et l'application Rosary (suivi de prière avec synchronisation Firebase et support hors ligne).",
          "third": "Intégration de l'API AWS Rekognition lors de l'inscription des utilisateurs, avec un seuil de confiance minimum de 90% pour la vérification faciale automatisée.",
          "fourth": "Utilisation de Riverpod pour une gestion d'état prévisible et création de couches d'intégration API RESTful résilientes avec gestion structurée des erreurs et du mode hors ligne.",
          "fifth": "Configuration de l'automatisation CI/CD via GitHub Actions et Codemagic, réduisant le temps d'exécution du pipeline de publication manuel de 15 minutes à moins de 2 minutes."
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
    "built_with": "Construit avec Flutter",
    "linkedinProfile": "Profil LinkedIn"
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
  },
  "cannot_open_cv": "Impossible d'ouvrir le CV. Veuillez réessayer plus tard.",
  "cv_download_error_title": "Erreur de Téléchargement",
  "cv_download_error_message": "Impossible d'ouvrir le CV. Le lien est peut-être corrompu ou temporairement indisponible.",
  "cv_download_error_close": "Fermer"
};
static const Map<String, Map<String,dynamic>> mapLocales = {"en": _en, "fr": _fr};
}
