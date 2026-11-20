import 'package:flutter/material.dart';

import '../data/portfolio_data.dart';
import '../theme/app_theme.dart';
import '../utils/launcher.dart';
import 'common.dart';

class NavItem {
  const NavItem(this.label, this.id);
  final String label;
  final SectionId id;
}

const navItems = <NavItem>[
  NavItem('Home', SectionId.home),
  NavItem('About', SectionId.about),
  NavItem('Skills', SectionId.skills),
  NavItem('Projects', SectionId.projects),
  NavItem('Education', SectionId.education),
  NavItem('Certifications', SectionId.certifications),
  NavItem('Contact', SectionId.contact),
];

class NavBar extends StatelessWidget {
  const NavBar({
    super.key,
    required this.active,
    required this.scrolled,
    required this.onNavigate,
    required this.onMenu,
  });

  final SectionId active;
  final bool scrolled;
  final ValueChanged<SectionId> onNavigate;
  final VoidCallback onMenu;

  @override
  Widget build(BuildContext context) {
    final compact = Responsive.width(context) < 1020;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: scrolled ? 0.97 : 0.86),
        border: Border(
          bottom: BorderSide(color: scrolled ? AppColors.border : Colors.transparent),
        ),
        boxShadow: scrolled
            ? [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.06),
                  blurRadius: 20,
                  offset: const Offset(0, 6),
                ),
              ]
            : const [],
      ),
      child: SafeArea(
        bottom: false,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1280),
            child: SizedBox(
              height: 72,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: Responsive.hPad(context)),
                child: Row(
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: () => onNavigate(SectionId.home),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const FlutterLogo(size: 34),
                          const SizedBox(width: 10),
                          Text(Profile.name, style: AppText.heading(19, weight: FontWeight.w600)),
                        ],
                      ),
                    ),
                    const Spacer(),
                    if (compact)
                      IconButton(
                        tooltip: 'Open menu',
                        onPressed: onMenu,
                        icon: const Icon(Icons.menu_rounded, color: AppColors.ink, size: 28),
                      )
                    else ...[
                      for (final item in navItems)
                        _NavLink(
                          label: item.label,
                          active: item.id == active,
                          onTap: () => onNavigate(item.id),
                        ),
                      const SizedBox(width: 28),
                      AppButton(
                        label: 'Download CV',
                        icon: Icons.download_rounded,
                        compact: true,
                        onPressed: openResume,
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavLink extends StatefulWidget {
  const _NavLink({required this.label, required this.active, required this.onTap});
  final String label;
  final bool active;
  final VoidCallback onTap;

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final highlighted = widget.active || _hover;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 180),
                style: AppText.body(
                  14,
                  color: highlighted ? AppColors.primary : AppColors.ink,
                  weight: widget.active ? FontWeight.w600 : FontWeight.w500,
                  height: 1.2,
                ),
                child: Text(widget.label),
              ),
              const SizedBox(height: 6),
              AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                curve: Curves.easeOut,
                height: 2,
                width: highlighted ? 24 : 0,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Mobile / tablet menu.
class NavDrawer extends StatelessWidget {
  const NavDrawer({super.key, required this.active, required this.onNavigate});
  final SectionId active;
  final ValueChanged<SectionId> onNavigate;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Row(
              children: [
                const FlutterLogo(size: 32),
                const SizedBox(width: 10),
                Text(Profile.name, style: AppText.heading(18, weight: FontWeight.w600)),
              ],
            ),
            const SizedBox(height: 24),
            for (final item in navItems)
              ListTile(
                selected: item.id == active,
                selectedColor: AppColors.primary,
                selectedTileColor: AppColors.soft,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                title: Text(item.label, style: AppText.body(16, weight: FontWeight.w600, height: 1.3, color: item.id == active ? AppColors.primary : AppColors.ink)),
                onTap: () => onNavigate(item.id),
              ),
            const SizedBox(height: 20),
            AppButton(
              label: 'Download CV',
              icon: Icons.download_rounded,
              onPressed: openResume,
            ),
          ],
        ),
      ),
    );
  }
}
