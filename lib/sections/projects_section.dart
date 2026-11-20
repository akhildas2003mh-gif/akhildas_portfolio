import 'package:flutter/material.dart';

import '../data/portfolio_data.dart';
import '../theme/app_theme.dart';
import '../utils/launcher.dart';
import '../widgets/common.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Reveal(
            child: SectionTitle(
              plain: 'My',
              accent: 'Projects',
              subtitle: 'A selection of apps I built while learning and practising Flutter.',
            ),
          ),
          const SizedBox(height: 40),
          ResponsiveGrid(
            children: [
              for (var i = 0; i < projects.length; i++)
                Reveal(
                  delay: Duration(milliseconds: 80 * (i % 3)),
                  child: _ProjectCard(project: projects[i]),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ProjectCard extends StatelessWidget {
  const _ProjectCard({required this.project});
  final Project project;

  @override
  Widget build(BuildContext context) {
    final p = project;
    return HoverLift(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Thumbnail(project: p),
          Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(p.name, style: AppText.heading(19, weight: FontWeight.w600)),
                const SizedBox(height: 8),
                Text(p.description, style: AppText.body(14.5, height: 1.6)),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [for (final t in p.tech) TagChip(t)],
                ),
                const SizedBox(height: 20),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    Tooltip(
                      message: p.githubUrl == null
                          ? 'Repository link coming soon'
                          : 'Open repository on GitHub',
                      child: AppButton(
                        label: 'GitHub',
                        icon: Icons.code_rounded,
                        filled: false,
                        compact: true,
                        onPressed: p.githubUrl == null ? null : () => openUrl(p.githubUrl!),
                      ),
                    ),
                    if (p.liveUrl != null)
                      AppButton(
                        label: 'Live Demo',
                        icon: Icons.open_in_new_rounded,
                        compact: true,
                        onPressed: () => openUrl(p.liveUrl!),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Illustrated thumbnail: gradient backdrop with a mini phone showing the
/// project's icon. Swap for real screenshots later if you like.
class _Thumbnail extends StatelessWidget {
  const _Thumbnail({required this.project});
  final Project project;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      child: Container(
        height: 180,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: project.gradient,
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              right: -30,
              top: -30,
              child: Container(
                width: 130,
                height: 130,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.12),
                ),
              ),
            ),
            Positioned(
              left: -20,
              bottom: -40,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.10),
                ),
              ),
            ),
            Container(
              width: 92,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.18),
                    blurRadius: 18,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(project.icon, size: 38, color: project.gradient.first),
                  const SizedBox(height: 10),
                  for (final w in const [54.0, 40.0])
                    Container(
                      width: w,
                      height: 6,
                      margin: const EdgeInsets.only(bottom: 6),
                      decoration: BoxDecoration(
                        color: AppColors.soft,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
