import 'package:flutter/material.dart';

import '../data/portfolio_data.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';

class EducationSection extends StatelessWidget {
  const EducationSection({super.key});

  @override
  Widget build(BuildContext context) {
    final wide = !Responsive.isMobile(context);
    const experience = Reveal(
      child: _Column(
        icon: Icons.work_rounded,
        title: 'Experience',
        entries: experienceEntries,
      ),
    );
    const education = Reveal(
      delay: Duration(milliseconds: 120),
      child: _Column(
        icon: Icons.school_rounded,
        title: 'Education & Training',
        entries: educationEntries,
      ),
    );

    return SectionShell(
      color: Colors.white,
      child: wide
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(child: experience),
                Container(
                  width: 1,
                  height: 260,
                  margin: const EdgeInsets.symmetric(horizontal: 36),
                  color: AppColors.border,
                ),
                const Expanded(child: education),
              ],
            )
          : const Column(children: [experience, SizedBox(height: 36), education]),
    );
  }
}

class _Column extends StatelessWidget {
  const _Column({required this.icon, required this.title, required this.entries});
  final IconData icon;
  final String title;
  final List<TimelineEntry> entries;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: AppColors.primary, size: 34),
            const SizedBox(width: 14),
            Flexible(
              child: Semantics(
                header: true,
                child: Text(title, style: AppText.heading(26, weight: FontWeight.w600)),
              ),
            ),
          ],
        ),
        const SizedBox(height: 22),
        for (final e in entries) ...[
          _EntryCard(entry: e),
          const SizedBox(height: 16),
        ],
      ],
    );
  }
}

class _EntryCard extends StatelessWidget {
  const _EntryCard({required this.entry});
  final TimelineEntry entry;

  @override
  Widget build(BuildContext context) {
    return HoverLift(
      lift: 4,
      radius: 16,
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 6),
            width: 12,
            height: 12,
            decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(entry.title, style: AppText.heading(17, weight: FontWeight.w600).copyWith(height: 1.3)),
                const SizedBox(height: 6),
                Text(entry.subtitle, style: AppText.body(14.5, height: 1.5)),
                for (final p in entry.points) ...[
                  const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 3),
                        child: Icon(Icons.check_circle_rounded, size: 16, color: AppColors.cyan),
                      ),
                      const SizedBox(width: 8),
                      Expanded(child: Text(p, style: AppText.body(14, height: 1.5))),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
