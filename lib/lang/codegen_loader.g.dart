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
    "work": "Work",
    "experience": "Experience",
    "stack": "Stack",
    "contact": "Contact",
    "language": "Language",
    "menu": "Open menu",
    "home": "Home"
  },
  "hero": {
    "eyebrow": "FULL-STACK DEVELOPER · LUBUMBASHI, DRC · REMOTE / HYBRID",
    "title": "I build enterprise web apps and the mobile apps people carry.",
    "subtitle": "C# and Blazor Server for the back office. Flutter for the phone. Clean Architecture, fast data access and release pipelines that take minutes, not hours.",
    "cta_work": "See the case studies",
    "cta_cv": "Download CV (PDF)",
    "status_label": "OPEN TO WORK",
    "status_text": "Building Kahvent, a wedding invitation app on Flutter and Supabase.",
    "portrait_alt": "Portrait of Pierre Junior Kahozi"
  },
  "facts": {
    "label": "Key facts",
    "since": "Shipping production software since",
    "pipeline": "Release pipeline after CI/CD rework",
    "face_match": "Face-match threshold, AWS Rekognition sign-up",
    "apps": "Client apps delivered, plus 1 live product"
  },
  "work": {
    "label": "01 / SELECTED WORK",
    "title": "Case studies",
    "read": "Read case study →",
    "open_live": "Open live app ↗",
    "also": "Also:",
    "also_rest": ", a weather app from my Flutter learning path (2022).",
    "role": "Role",
    "platforms": "Platforms",
    "stack": "Stack",
    "security": "Security"
  },
  "status": {
    "live": "● LIVE · IN DEVELOPMENT",
    "own": "OWN PRODUCT",
    "retired": "DELIVERED FOR {} · RETIRED",
    "learning": "LEARNING PROJECT"
  },
  "experience": {
    "label": "02 / EXPERIENCE",
    "title": "Where I've worked",
    "education": "National Diploma, Business Information Technology, University of Johannesburg (2017–2022).",
    "jobs": {
      "kcc": {
        "role": "Software Developer Intern",
        "duration": "FEB 2026 — OCT 2026",
        "items": {
          "first": "Built an internal Blazor Server application with layered Clean Architecture.",
          "second": "Split data access: EF Core for schema, Dapper for latency-sensitive MSSQL queries.",
          "third": "Shipped PDF (QuestPDF) and streamed Excel (ClosedXML) reporting."
        }
      },
      "upskilling": {
        "role": "Upskilling",
        "duration": "JAN 2025 — JAN 2026",
        "items": {
          "first": "Sharpened my skills through self-study while looking for my next role."
        }
      },
      "akrotech": {
        "role": "Junior Software Developer",
        "duration": "SEPT 2022 — DEC 2024",
        "items": {
          "first": "Delivered Tahadhari and Rosary to production in Flutter.",
          "second": "Cut release time from 15 min to under 2 min with GitHub Actions and Codemagic.",
          "third": "Added AWS Rekognition face checks at sign-up (90% confidence minimum)."
        }
      }
    }
  },
  "stack": {
    "label": "03 / STACK",
    "title": "What I use, grouped by job",
    "web": "Web & back end",
    "mobile": "Mobile",
    "data": "Cloud & data",
    "delivery": "Delivery"
  },
  "contact": {
    "label": "04 / CONTACT",
    "title": "Hiring for .NET or Flutter? Let's talk.",
    "subtitle": "Open to remote and hybrid roles. I reply within two working days.",
    "email": "Email me",
    "linkedin": "LinkedIn ↗",
    "cv": "CV · EN / FR",
    "built_with": "Built with Flutter"
  },
  "study": {
    "label": "CASE STUDY",
    "problem": "The problem",
    "built": "What I built",
    "architecture": "Architecture",
    "diagram_caption": "Request path from the user's phone to the backend.",
    "decisions": "Key decisions",
    "decision": "DECISION",
    "code": "Code excerpt",
    "screens": "Screens",
    "role": "ROLE",
    "stack": "STACK",
    "platforms": "PLATFORMS",
    "status": "STATUS",
    "back": "← Back to all work",
    "all_work": "← All work",
    "next": "Next: {} →",
    "not_found": "This case study doesn't exist.",
    "screenshot": "Screenshot {} of {}",
    "close": "Close",
    "previous_shot": "Previous screenshot",
    "next_shot": "Next screenshot"
  },
  "projects": {
    "kahvent": {
      "title": "Kahvent",
      "summary": "Wedding invitations on paper get lost and can't be checked at the door. In Kahvent, each guest's link is both their invitation and their QR entry pass.",
      "headline": "Kahvent: one link that is the invitation and the entry pass",
      "period": "PERSONAL PROJECT · OCT 2026 — NOW",
      "role": "Solo: product, design, full stack",
      "platforms": "Android and web from one Flutter codebase",
      "security": "Row-level security on every table, hashed link tokens",
      "status": "Live, in development ↗",
      "problem": {
        "first": "Wedding hosts in Lubumbashi still print invitation cards. Cards get lost, guests forward photos of them, and the door team has no way to know who is really invited or how many seats a family was given.",
        "second": "I wanted one thing a host can send by WhatsApp that also works at the door."
      },
      "features": {
        "f1_title": "Guest links + QR pass",
        "f1_body": "Each guest party gets one link. It shows the invitation and turns into a QR code at the door.",
        "f2_title": "Team roles",
        "f2_body": "Hosts invite helpers by team code. Each role sees only what it needs.",
        "f3_title": "Seat planning",
        "f3_body": "Seats are given per party, so a family of five uses one pass.",
        "f4_title": "Excel / CSV import",
        "f4_body": "Hosts paste the guest list they already have instead of typing it again."
      },
      "arch": {
        "client": "Guest page · host dashboard · staff screens lazy-loaded",
        "state": "Repositories behind providers",
        "backend": "Auth · PostgreSQL with RLS and column grants",
        "edge": "Static hosting, custom domain"
      },
      "decisions": {
        "d1_title": "Permissions live in the database",
        "d1_body": "Row-level security and column-level grants on every table, in versioned migrations. No permission depends on app code.",
        "d2_title": "Link tokens stored only as hashes",
        "d2_body": "A guest's link is their entry pass, so a database leak must not expose working links.",
        "d3_title": "One codebase, staff screens lazy-loaded",
        "d3_body": "Android and web from one Flutter app. Guests download only the guest page; staff-only screens load on demand."
      },
      "shot_card": "Kahvent dashboard showing upcoming events and guest counts",
      "shot_hero": "Kahvent event overview with guest parties, RSVP status and seat counts"
    },
    "tahadhari": {
      "title": "Tahadhari",
      "summary": "Emergency alert app. A user raises an alert, their location and next of kin are notified by push in real time. Face verification at sign-up with AWS Rekognition.",
      "headline": "Tahadhari: real-time emergency alerts with verified users",
      "period": "AKROTECH · 2022 — 2024",
      "role": "Flutter developer in the Akrotech team",
      "platforms": "Android and iOS",
      "status": "Retired",
      "problem": {
        "first": "In an emergency, an alert is only useful if it arrives at once, shows where the person is, and comes from a real user.",
        "second": "Tahadhari broadcasts real-time alerts with live location, in English and French, and checks every new account with a face match."
      },
      "features": {
        "f1_title": "Live GPS tracking",
        "f1_body": "The alert carries the user's live location, shown on a map.",
        "f2_title": "Push alerts",
        "f2_body": "Firebase Cloud Messaging delivers alerts in real time.",
        "f3_title": "Face check at sign-up",
        "f3_body": "AWS Rekognition must match the user's face with at least 90% confidence.",
        "f4_title": "English and French",
        "f4_body": "The whole app and its alerts are localized with Flutter."
      },
      "arch": {
        "client": "Alert button · live map · EN / FR",
        "state": "REST layer with structured error and offline handling",
        "backend": "Firebase Cloud Messaging for real-time alerts",
        "edge": "Face match at sign-up, 90% minimum"
      },
      "decisions": {
        "d1_title": "Verify faces at sign-up",
        "d1_body": "Only authentic profiles can register: AWS Rekognition must report at least 90% confidence.",
        "d2_title": "Built for poor connectivity",
        "d2_body": "Riverpod state and a REST layer with structured error and offline handling keep the app predictable.",
        "d3_title": "Release in minutes",
        "d3_body": "GitHub Actions and Codemagic cut the release pipeline from 15 minutes to under 2."
      },
      "shot_card": "Tahadhari map screen showing an active alert location",
      "shot_hero": "Tahadhari map screen showing an active alert location"
    },
    "rosary": {
      "title": "Rosary",
      "summary": "Prayer tracker that shows the right mysteries for each day. Firebase sync with offline support, monetised with AdMob.",
      "headline": "Rosary: a prayer tracker that works fully offline",
      "period": "AKROTECH · 2022 — 2024",
      "role": "Flutter developer in the Akrotech team",
      "platforms": "Android and iOS",
      "status": "Retired",
      "problem": {
        "first": "People pray where the connection is weak or absent, so a prayer app has to work without a network.",
        "second": "Rosary shows the right content for each day, works fully offline and syncs in real time when the network comes back."
      },
      "features": {
        "f1_title": "Day-based content",
        "f1_body": "The app shows the right mysteries for the day of the week.",
        "f2_title": "Offline first",
        "f2_body": "Content is cached on the device, so the app works with no signal.",
        "f3_title": "Real-time sync",
        "f3_body": "Firestore syncs the user's progress across devices.",
        "f4_title": "AdMob",
        "f4_body": "Non-intrusive ads fund the app."
      },
      "arch": {
        "client": "Daily prayers and progress",
        "state": "Offline-first cache on the device",
        "backend": "Firestore real-time sync",
        "edge": "Non-intrusive ads"
      },
      "decisions": {
        "d1_title": "Offline first",
        "d1_body": "The device cache is the source the UI reads from; Firestore syncs in the background.",
        "d2_title": "Content follows the calendar",
        "d2_body": "Day-based liturgical content is picked on the device, so it works offline too.",
        "d3_title": "Ads that stay out of the way",
        "d3_body": "AdMob placements are non-intrusive, so prayer comes first."
      },
      "shot_card": "Rosary app daily prayer screen",
      "shot_hero": "Rosary app daily prayer screen"
    },
    "clima": {
      "title": "Clima",
      "summary": "Weather app that shows the current weather for the user's location.",
      "headline": "Clima: current weather for where you are",
      "period": "LEARNING PROJECT · 2022",
      "role": "Solo, Flutter bootcamp project",
      "platforms": "Android and iOS",
      "status": "Learning project",
      "problem": {
        "first": "A learning project from the Flutter bootcamp: call a real API, use device location and handle async data.",
        "second": "Clima reads the phone's location and shows the current weather from OpenWeatherMap."
      },
      "features": {
        "f1_title": "Location aware",
        "f1_body": "Uses geolocation to find the user's city.",
        "f2_title": "Live weather",
        "f2_body": "Fetches current conditions from the OpenWeatherMap API."
      },
      "arch": {
        "client": "Weather screen and city search",
        "state": "Device location",
        "backend": "Current conditions API"
      },
      "shot_card": "Clima weather screen",
      "shot_hero": "Clima weather screen"
    }
  },
  "cv_download_error_title": "Download Error",
  "cv_download_error_message": "Could not open the CV. The link may be broken or temporarily unavailable.",
  "cv_download_error_close": "Close"
};
static const Map<String,dynamic> _fr = {
  "nav": {
    "work": "Projets",
    "experience": "Expérience",
    "stack": "Stack",
    "contact": "Contact",
    "language": "Langue",
    "menu": "Ouvrir le menu",
    "home": "Accueil"
  },
  "hero": {
    "eyebrow": "DÉVELOPPEUR FULL-STACK · LUBUMBASHI, RDC · À DISTANCE / HYBRIDE",
    "title": "Je crée des applications web d'entreprise et les applications mobiles qu'on garde en poche.",
    "subtitle": "C# et Blazor Server pour le back-office. Flutter pour le téléphone. Clean Architecture, accès aux données rapide et pipelines de publication qui prennent des minutes, pas des heures.",
    "cta_work": "Voir les études de cas",
    "cta_cv": "Télécharger le CV (PDF)",
    "status_label": "DISPONIBLE",
    "status_text": "Je développe Kahvent, une application d'invitations de mariage en Flutter et Supabase.",
    "portrait_alt": "Portrait de Pierre Junior Kahozi"
  },
  "facts": {
    "label": "Chiffres clés",
    "since": "Je livre des logiciels en production depuis",
    "pipeline": "Pipeline de publication après refonte CI/CD",
    "face_match": "Seuil de reconnaissance faciale, inscription AWS Rekognition",
    "apps": "Applications client livrées, plus 1 produit en ligne"
  },
  "work": {
    "label": "01 / PROJETS CHOISIS",
    "title": "Études de cas",
    "read": "Lire l'étude de cas →",
    "open_live": "Ouvrir l'application ↗",
    "also": "Aussi :",
    "also_rest": ", une application météo de mon apprentissage Flutter (2022).",
    "role": "Rôle",
    "platforms": "Plateformes",
    "stack": "Stack",
    "security": "Sécurité"
  },
  "status": {
    "live": "● EN LIGNE · EN DÉVELOPPEMENT",
    "own": "PROJET PERSONNEL",
    "retired": "LIVRÉ POUR {} · RETIRÉ",
    "learning": "PROJET D'APPRENTISSAGE"
  },
  "experience": {
    "label": "02 / EXPÉRIENCE",
    "title": "Où j'ai travaillé",
    "education": "National Diploma, Business Information Technology, Université de Johannesburg (2017–2022).",
    "jobs": {
      "kcc": {
        "role": "Développeur logiciel stagiaire",
        "duration": "FÉV 2026 — OCT 2026",
        "items": {
          "first": "Développement d'une application Blazor Server interne en Clean Architecture par couches.",
          "second": "Accès aux données séparé : EF Core pour le schéma, Dapper pour les requêtes MSSQL sensibles à la latence.",
          "third": "Livraison de rapports PDF (QuestPDF) et d'exports Excel en streaming (ClosedXML)."
        }
      },
      "upskilling": {
        "role": "Perfectionnement",
        "duration": "JAN 2025 — JAN 2026",
        "items": {
          "first": "J'ai renforcé mes compétences en autoformation tout en cherchant mon prochain poste."
        }
      },
      "akrotech": {
        "role": "Développeur logiciel junior",
        "duration": "SEPT 2022 — DÉC 2024",
        "items": {
          "first": "Mise en production de Tahadhari et Rosary en Flutter.",
          "second": "Temps de publication réduit de 15 min à moins de 2 min avec GitHub Actions et Codemagic.",
          "third": "Vérification faciale AWS Rekognition à l'inscription (confiance minimale de 90 %)."
        }
      }
    }
  },
  "stack": {
    "label": "03 / STACK",
    "title": "Mes outils, regroupés par usage",
    "web": "Web et back-end",
    "mobile": "Mobile",
    "data": "Cloud et données",
    "delivery": "Livraison"
  },
  "contact": {
    "label": "04 / CONTACT",
    "title": "Vous recrutez en .NET ou Flutter ? Parlons-en.",
    "subtitle": "Ouvert aux postes à distance et hybrides. Je réponds sous deux jours ouvrés.",
    "email": "M'écrire",
    "linkedin": "LinkedIn ↗",
    "cv": "CV · EN / FR",
    "built_with": "Construit avec Flutter"
  },
  "study": {
    "label": "ÉTUDE DE CAS",
    "problem": "Le problème",
    "built": "Ce que j'ai construit",
    "architecture": "Architecture",
    "diagram_caption": "Chemin d'une requête, du téléphone de l'utilisateur au back-end.",
    "decisions": "Décisions clés",
    "decision": "DÉCISION",
    "code": "Extrait de code",
    "screens": "Écrans",
    "role": "RÔLE",
    "stack": "STACK",
    "platforms": "PLATEFORMES",
    "status": "STATUT",
    "back": "← Retour aux projets",
    "all_work": "← Tous les projets",
    "next": "Suivant : {} →",
    "not_found": "Cette étude de cas n'existe pas.",
    "screenshot": "Capture {} sur {}",
    "close": "Fermer",
    "previous_shot": "Capture précédente",
    "next_shot": "Capture suivante"
  },
  "projects": {
    "kahvent": {
      "title": "Kahvent",
      "summary": "Les invitations de mariage sur papier se perdent et ne peuvent pas être vérifiées à l'entrée. Avec Kahvent, le lien de chaque invité est à la fois son invitation et son pass d'entrée QR.",
      "headline": "Kahvent : un lien qui sert d'invitation et de pass d'entrée",
      "period": "PROJET PERSONNEL · OCT 2026 — AUJOURD'HUI",
      "role": "Seul : produit, design, full-stack",
      "platforms": "Android et web avec une seule base de code Flutter",
      "security": "Sécurité au niveau des lignes sur chaque table, jetons de lien hachés",
      "status": "En ligne, en développement ↗",
      "problem": {
        "first": "À Lubumbashi, les organisateurs de mariage impriment encore des cartes d'invitation. Les cartes se perdent, les invités en transfèrent des photos, et l'équipe à l'entrée ne peut pas savoir qui est vraiment invité ni combien de places une famille a reçues.",
        "second": "Je voulais une seule chose qu'un organisateur puisse envoyer par WhatsApp et qui fonctionne aussi à l'entrée."
      },
      "features": {
        "f1_title": "Liens invités + pass QR",
        "f1_body": "Chaque groupe d'invités reçoit un lien. Il affiche l'invitation et devient un QR code à l'entrée.",
        "f2_title": "Rôles d'équipe",
        "f2_body": "Les organisateurs invitent leurs aides avec un code d'équipe. Chaque rôle ne voit que ce dont il a besoin.",
        "f3_title": "Gestion des places",
        "f3_body": "Les places sont attribuées par groupe : une famille de cinq utilise un seul pass.",
        "f4_title": "Import Excel / CSV",
        "f4_body": "Les organisateurs importent la liste d'invités qu'ils ont déjà au lieu de la retaper."
      },
      "arch": {
        "client": "Page invité · tableau de bord · écrans du personnel chargés à la demande",
        "state": "Repositories derrière des providers",
        "backend": "Auth · PostgreSQL avec RLS et droits par colonne",
        "edge": "Hébergement statique, domaine personnalisé"
      },
      "decisions": {
        "d1_title": "Les permissions vivent dans la base de données",
        "d1_body": "Sécurité au niveau des lignes et droits par colonne sur chaque table, dans des migrations versionnées. Aucune permission ne dépend du code de l'application.",
        "d2_title": "Jetons de lien stockés uniquement hachés",
        "d2_body": "Le lien d'un invité est son pass d'entrée : une fuite de la base ne doit pas exposer de liens valides.",
        "d3_title": "Une base de code, écrans du personnel chargés à la demande",
        "d3_body": "Android et web depuis une seule application Flutter. Les invités ne téléchargent que leur page ; les écrans du personnel se chargent à la demande."
      },
      "shot_card": "Tableau de bord Kahvent avec les événements à venir et le nombre d'invités",
      "shot_hero": "Vue d'un événement Kahvent avec les groupes d'invités, les réponses et les places"
    },
    "tahadhari": {
      "title": "Tahadhari",
      "summary": "Application d'alerte d'urgence. L'utilisateur lance une alerte, sa position et ses proches sont notifiés en temps réel. Vérification faciale à l'inscription avec AWS Rekognition.",
      "headline": "Tahadhari : des alertes d'urgence en temps réel, par des utilisateurs vérifiés",
      "period": "AKROTECH · 2022 — 2024",
      "role": "Développeur Flutter dans l'équipe Akrotech",
      "platforms": "Android et iOS",
      "status": "Retiré",
      "problem": {
        "first": "En cas d'urgence, une alerte n'est utile que si elle arrive tout de suite, montre où se trouve la personne et vient d'un vrai utilisateur.",
        "second": "Tahadhari diffuse des alertes en temps réel avec la position en direct, en anglais et en français, et vérifie chaque nouveau compte par reconnaissance faciale."
      },
      "features": {
        "f1_title": "Suivi GPS en direct",
        "f1_body": "L'alerte transmet la position en direct de l'utilisateur, affichée sur une carte.",
        "f2_title": "Alertes push",
        "f2_body": "Firebase Cloud Messaging livre les alertes en temps réel.",
        "f3_title": "Vérification faciale à l'inscription",
        "f3_body": "AWS Rekognition doit reconnaître le visage avec au moins 90 % de confiance.",
        "f4_title": "Anglais et français",
        "f4_body": "Toute l'application et ses alertes sont localisées avec Flutter."
      },
      "arch": {
        "client": "Bouton d'alerte · carte en direct · EN / FR",
        "state": "Couche REST avec gestion structurée des erreurs et du hors-ligne",
        "backend": "Firebase Cloud Messaging pour les alertes en temps réel",
        "edge": "Reconnaissance faciale à l'inscription, 90 % minimum"
      },
      "decisions": {
        "d1_title": "Vérifier les visages à l'inscription",
        "d1_body": "Seuls les profils authentiques peuvent s'inscrire : AWS Rekognition doit indiquer au moins 90 % de confiance.",
        "d2_title": "Pensé pour une connexion faible",
        "d2_body": "L'état Riverpod et une couche REST avec gestion structurée des erreurs et du hors-ligne gardent l'application prévisible.",
        "d3_title": "Publier en quelques minutes",
        "d3_body": "GitHub Actions et Codemagic ont réduit le pipeline de publication de 15 minutes à moins de 2."
      },
      "shot_card": "Écran carte de Tahadhari montrant la position d'une alerte active",
      "shot_hero": "Écran carte de Tahadhari montrant la position d'une alerte active"
    },
    "rosary": {
      "title": "Rosary",
      "summary": "Suivi de prière qui affiche les bons mystères pour chaque jour. Synchronisation Firebase avec mode hors ligne, monétisé avec AdMob.",
      "headline": "Rosary : un suivi de prière qui fonctionne entièrement hors ligne",
      "period": "AKROTECH · 2022 — 2024",
      "role": "Développeur Flutter dans l'équipe Akrotech",
      "platforms": "Android et iOS",
      "status": "Retiré",
      "problem": {
        "first": "On prie souvent là où la connexion est faible ou absente : une application de prière doit fonctionner sans réseau.",
        "second": "Rosary affiche le bon contenu pour chaque jour, fonctionne entièrement hors ligne et se synchronise en temps réel au retour du réseau."
      },
      "features": {
        "f1_title": "Contenu selon le jour",
        "f1_body": "L'application affiche les bons mystères selon le jour de la semaine.",
        "f2_title": "Hors ligne d'abord",
        "f2_body": "Le contenu est mis en cache sur l'appareil : l'application fonctionne sans signal.",
        "f3_title": "Synchronisation en temps réel",
        "f3_body": "Firestore synchronise la progression entre les appareils.",
        "f4_title": "AdMob",
        "f4_body": "Des publicités discrètes financent l'application."
      },
      "arch": {
        "client": "Prières du jour et progression",
        "state": "Cache hors ligne sur l'appareil",
        "backend": "Synchronisation Firestore en temps réel",
        "edge": "Publicités discrètes"
      },
      "decisions": {
        "d1_title": "Hors ligne d'abord",
        "d1_body": "L'interface lit le cache de l'appareil ; Firestore synchronise en arrière-plan.",
        "d2_title": "Le contenu suit le calendrier",
        "d2_body": "Le contenu liturgique du jour est choisi sur l'appareil, donc il fonctionne aussi hors ligne.",
        "d3_title": "Des publicités qui ne dérangent pas",
        "d3_body": "Les emplacements AdMob restent discrets : la prière passe d'abord."
      },
      "shot_card": "Écran de prière du jour de l'application Rosary",
      "shot_hero": "Écran de prière du jour de l'application Rosary"
    },
    "clima": {
      "title": "Clima",
      "summary": "Application météo qui affiche la météo actuelle à la position de l'utilisateur.",
      "headline": "Clima : la météo actuelle là où vous êtes",
      "period": "PROJET D'APPRENTISSAGE · 2022",
      "role": "Seul, projet du bootcamp Flutter",
      "platforms": "Android et iOS",
      "status": "Projet d'apprentissage",
      "problem": {
        "first": "Un projet d'apprentissage du bootcamp Flutter : appeler une vraie API, utiliser la position de l'appareil et gérer des données asynchrones.",
        "second": "Clima lit la position du téléphone et affiche la météo actuelle via OpenWeatherMap."
      },
      "features": {
        "f1_title": "Selon la position",
        "f1_body": "Utilise la géolocalisation pour trouver la ville de l'utilisateur.",
        "f2_title": "Météo en direct",
        "f2_body": "Récupère les conditions actuelles depuis l'API OpenWeatherMap."
      },
      "arch": {
        "client": "Écran météo et recherche de ville",
        "state": "Position de l'appareil",
        "backend": "API des conditions actuelles"
      },
      "shot_card": "Écran météo de Clima",
      "shot_hero": "Écran météo de Clima"
    }
  },
  "cv_download_error_title": "Erreur de téléchargement",
  "cv_download_error_message": "Impossible d'ouvrir le CV. Le lien est peut-être cassé ou temporairement indisponible.",
  "cv_download_error_close": "Fermer"
};
static const Map<String, Map<String,dynamic>> mapLocales = {"en": _en, "fr": _fr};
}
