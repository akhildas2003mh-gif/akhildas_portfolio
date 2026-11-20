import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'data/portfolio_data.dart';
import 'sections/about_section.dart';
import 'sections/certifications_section.dart';
import 'sections/contact_section.dart';
import 'sections/education_section.dart';
import 'sections/footer_section.dart';
import 'sections/hero_section.dart';
import 'sections/projects_section.dart';
import 'sections/skills_section.dart';
import 'theme/app_theme.dart';
import 'widgets/nav_bar.dart';

void main() {
  VisibilityDetectorController.instance.updateInterval =
      const Duration(milliseconds: 80);
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '${Profile.name} | ${Profile.title}',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _controller = ScrollController();
  final _keys = {for (final s in SectionId.values) s: GlobalKey()};

  SectionId _active = SectionId.home;
  bool _scrolled = false;
  bool _showTop = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onScroll);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onScroll() {
    final offset = _controller.offset;
    var current = SectionId.home;
    for (final id in SectionId.values) {
      final ctx = _keys[id]!.currentContext;
      final box = ctx?.findRenderObject();
      if (box is! RenderBox || !box.attached) continue;
      if (box.localToGlobal(Offset.zero).dy <= 160) current = id;
    }
    final scrolled = offset > 8;
    final showTop = offset > 700;
    if (current != _active || scrolled != _scrolled || showTop != _showTop) {
      setState(() {
        _active = current;
        _scrolled = scrolled;
        _showTop = showTop;
      });
    }
  }

  void _goTo(SectionId id) {
    if (_scaffoldKey.currentState?.isEndDrawerOpen ?? false) {
      Navigator.of(context).pop();
    }
    final ctx = _keys[id]!.currentContext;
    if (ctx == null) return;
    Scrollable.ensureVisible(
      ctx,
      duration: MediaQuery.disableAnimationsOf(context)
          ? Duration.zero
          : const Duration(milliseconds: 750),
      curve: Curves.easeInOutCubic,
    );
  }

  Widget _section(SectionId id, Widget child) =>
      KeyedSubtree(key: _keys[id], child: child);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: NavDrawer(active: _active, onNavigate: _goTo),
      floatingActionButton: AnimatedScale(
        scale: _showTop ? 1 : 0,
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutBack,
        child: FloatingActionButton(
          tooltip: 'Back to top',
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          onPressed: () => _controller.animateTo(
            0,
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeInOutCubic,
          ),
          child: const Icon(Icons.keyboard_arrow_up_rounded, size: 30),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _controller,
            child: Column(
              children: [
                _section(
                  SectionId.home,
                  HeroSection(
                    onProjects: () => _goTo(SectionId.projects),
                    onContact: () => _goTo(SectionId.contact),
                  ),
                ),
                _section(SectionId.about, const AboutSection()),
                _section(SectionId.skills, const SkillsSection()),
                _section(SectionId.projects, const ProjectsSection()),
                _section(SectionId.education, const EducationSection()),
                _section(SectionId.certifications, const CertificationsSection()),
                _section(SectionId.contact, const ContactSection()),
                FooterSection(onNavigate: _goTo),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: NavBar(
              active: _active,
              scrolled: _scrolled,
              onNavigate: _goTo,
              onMenu: () => _scaffoldKey.currentState?.openEndDrawer(),
            ),
          ),
        ],
      ),
    );
  }
}
