import 'package:flutter/material.dart';

/// ---------------------------------------------------------------------------
/// All portfolio content lives here. Edit this file, not the widgets.
///
/// Anything set to `null` (GitHub / LinkedIn / live demo URLs, certificate
/// images) is intentionally left empty so no fake link is ever published.
/// Fill them in with your real URLs when you have them.
/// ---------------------------------------------------------------------------

enum SectionId { home, about, skills, projects, education, certifications, contact }

class Profile {
  Profile._();

  static const name = 'AKHILDAS M.H';
  static const firstName = 'AKHILDAS';
  static const lastName = 'M.H';
  static const role = 'Flutter Developer';
  static const title = 'Flutter Developer | Mobile Application Developer';
  static const email =  'akhildasmh@gmail.com';
  static const location = 'India';

  /// Put your PDF at web/resume/AKHILDAS_MH_Resume.pdf
  static const resumePath = 'resume/Shithin_KS_Resume.pdf';

  static const intro =
      'A passionate Flutter Developer and BCA graduate interested in building '
      'beautiful, scalable, and user-friendly mobile applications. Skilled in '
      'Dart, Flutter, Firebase, REST API integration, and modern application '
      'development practices.';

  static const aboutParagraphs = <String>[
    'I am a fresher Flutter Developer from India with a Bachelor of Computer '
        'Applications (BCA) degree. I completed the Flutter Full Stack Mobile '
        'Application Development program at Luminar Technolab, where I learned to '
        'take an app from idea to a working product.',
    'I enjoy turning designs into smooth, responsive interfaces and connecting '
        'them to real data using Firebase and REST APIs. I am always eager to '
        'learn new technologies and improve my code quality.',
  ];

  static const objective =
      'Career objective: to join a product-focused team as a Flutter Developer, '
      'contribute to real mobile applications and grow into a well-rounded '
      'mobile engineer.';

  static const interests = <String>[
    'Mobile UI/UX',
    'Clean architecture',
    'State management',
    'Firebase & APIs',
    'Continuous learning',
  ];
}

class SocialLink {
  const SocialLink({required this.label, required this.icon, required this.color, this.url});
  final String label;
  final IconData icon;
  final Color color;

  /// null => not published yet (the button explains what to do instead of
  /// opening a made-up address).
  final String? url;
}

class Socials {
  Socials._();

  static const github = SocialLink(
    label: 'GitHub',
    icon: Icons.code_rounded,
    color: Color(0xFF24292F),
    url: null, // TODO: e.g. https://github.com/<your-username>
  );
  static const linkedin = SocialLink(
    label: 'LinkedIn',
    icon: Icons.people_alt_rounded,
    color: Color(0xFF0A66C2),
    url: null, // TODO: e.g. https://www.linkedin.com/in/<your-handle>
  );
  static const emailLink = SocialLink(
    label: 'Email',
    icon: Icons.email_rounded,
    color: Color(0xFFEA4335),
    url: 'mailto:${Profile.email}',
  );

  static const all = [github, linkedin, emailLink];
}

class Skill {
  const Skill(this.name, this.short, this.color);
  final String name;
  final String short;
  final Color color;
}

class SkillCategory {
  const SkillCategory(this.title, this.icon, this.skills);
  final String title;
  final IconData icon;
  final List<Skill> skills;
}

const skillCategories = <SkillCategory>[
  SkillCategory('Programming', Icons.code_rounded, [
    Skill('Dart', 'D', Color(0xFF0175C2)),
    Skill('Java', 'J', Color(0xFFD35400)),
    Skill('Python', 'Py', Color(0xFF3776AB)),
    Skill('JavaScript', 'JS', Color(0xFF8A6D00)),
  ]),
  SkillCategory('Mobile Development', Icons.phone_android_rounded, [
    Skill('Flutter', 'Fl', Color(0xFF0A8CD8)),
    Skill('Android', 'An', Color(0xFF2E9E5B)),
  ]),
  SkillCategory('State Management', Icons.account_tree_outlined, [
    Skill('Provider', 'Pv', Color(0xFF1D4ED8)),
    Skill('Riverpod', 'Rp', Color(0xFF0E7490)),
    Skill('BLoC', 'Bl', Color(0xFF0B5FA5)),
    Skill('GetX', 'Gx', Color(0xFF7C3AED)),
  ]),
  SkillCategory('Backend', Icons.cloud_outlined, [
    Skill('Firebase', 'Fb', Color(0xFFC2410C)),
    Skill('REST API', 'API', Color(0xFF0F766E)),
  ]),
  SkillCategory('Database', Icons.storage_outlined, [
    Skill('SQLite', 'SQ', Color(0xFF0B6BA8)),
    Skill('Hive', 'Hv', Color(0xFFB45309)),
    Skill('MySQL', 'My', Color(0xFF00758F)),
  ]),
  SkillCategory('Tools', Icons.build_outlined, [
    Skill('Android Studio', 'AS', Color(0xFF2E9E5B)),
    Skill('VS Code', 'VS', Color(0xFF0A66C2)),
    Skill('Git', 'Gt', Color(0xFFD9480F)),
    Skill('GitHub', 'GH', Color(0xFF24292F)),
    Skill('Postman', 'Pm', Color(0xFFE8590C)),
  ]),
];

class Project {
  const Project({
    required this.name,
    required this.description,
    required this.tech,
    required this.icon,
    required this.gradient,
    this.githubUrl,
    this.liveUrl,
  });
  final String name;
  final String description;
  final List<String> tech;
  final IconData icon;
  final List<Color> gradient;
  final String? githubUrl;
  final String? liveUrl;
}

/// Sample project descriptions: replace with the details of your own builds.
const projects = <Project>[
  Project(
    name: 'E-Commerce Mobile App',
    description:
        'Shopping app with product listing, search, cart and a simple checkout flow.',
    tech: ['Flutter', 'REST API', 'Provider', 'SQLite'],
    icon: Icons.shopping_bag_rounded,
    gradient: [Color(0xFF1E88E5), Color(0xFF13B9FD)],
  ),
  Project(
    name: 'Todo / Task Manager',
    description:
        'Clean task manager with categories, due dates and offline storage.',
    tech: ['Flutter', 'Hive', 'Provider'],
    icon: Icons.checklist_rounded,
    gradient: [Color(0xFF3949AB), Color(0xFF5C8DF6)],
  ),
  Project(
    name: 'Weather App',
    description:
        'Shows current conditions and a multi-day forecast from a public weather API.',
    tech: ['Flutter', 'REST API', 'GetX'],
    icon: Icons.wb_sunny_rounded,
    gradient: [Color(0xFF0288D1), Color(0xFF4DD0E1)],
  ),
  Project(
    name: 'Student Management App',
    description:
        'Add, edit and search student records with cloud sync and form validation.',
    tech: ['Flutter', 'Firebase', 'Riverpod'],
    icon: Icons.school_rounded,
    gradient: [Color(0xFF0A5BD8), Color(0xFF6C9DFF)],
  ),
  Project(
    name: 'Chat Application',
    description:
        'Real-time one-to-one messaging with authentication and message history.',
    tech: ['Flutter', 'Firebase', 'BLoC'],
    icon: Icons.chat_bubble_rounded,
    gradient: [Color(0xFF00897B), Color(0xFF26C6DA)],
  ),
];

class TimelineEntry {
  const TimelineEntry({required this.title, required this.subtitle, this.points = const []});
  final String title;
  final String subtitle;
  final List<String> points;
}

const experienceEntries = <TimelineEntry>[
  TimelineEntry(
    title: 'Flutter Developer (Fresher)',
    subtitle: 'Exploring opportunities to contribute in Flutter development.',
  ),
  TimelineEntry(
    title: 'Hands-on Project Work',
    subtitle: 'Luminar Technolab training projects',
    points: [
      'Built sample apps using Flutter, Firebase and REST APIs',
      'Practised state management and local storage',
    ],
  ),
];

const educationEntries = <TimelineEntry>[
  TimelineEntry(
    title: 'Bachelor of Computer Applications (BCA)',
    subtitle: 'Calicut University | 2021 – 2024',
  ),
  TimelineEntry(
    title: 'Flutter Full Stack Mobile Application Development',
    subtitle: 'Luminar Technolab',
    points: [
      'Dart, Flutter widgets and responsive layouts',
      'State management, Firebase and REST API integration',
    ],
  ),
];

class Certification {
  const Certification({required this.title, required this.issuer, this.imageAsset});
  final String title;
  final String issuer;

  /// e.g. 'assets/certificates/luminar.png' (add the file, then set this).
  final String? imageAsset;
}

const certifications = <Certification>[
  Certification(
    title: 'Flutter Full Stack Mobile Application Development',
    issuer: 'Luminar Technolab',
  ),
  Certification(title: 'Your next certification', issuer: 'Issuing organisation'),
  Certification(title: 'Your next certification', issuer: 'Issuing organisation'),
];
