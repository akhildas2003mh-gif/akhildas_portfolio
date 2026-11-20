import 'package:flutter/material.dart';

import '../data/portfolio_data.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionShell(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Reveal(
            child: SectionTitle(
              plain: 'My',
              accent: 'Skills',
              subtitle: 'Technologies and tools I work with while building mobile applications.',
            ),
          ),
          const SizedBox(height: 40),
          ResponsiveGrid(
            children: [
              for (var i = 0; i < skillCategories.length; i++)
                Reveal(
                  delay: Duration(milliseconds: 80 * (i % 3)),
                  child: _SkillCard(category: skillCategories[i]),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SkillCard extends StatelessWidget {
  const _SkillCard({required this.category});
  final SkillCategory category;

  @override
  Widget build(BuildContext context) {
    return HoverLift(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [AppColors.cyan, AppColors.primary]),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(category.icon, color: Colors.white, size: 22),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  category.title,
                  style: AppText.heading(18, weight: FontWeight.w600),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [for (final s in category.skills) _SkillChip(skill: s)],
          ),
        ],
      ),
    );
  }
}

class _SkillChip extends StatefulWidget {
  const _SkillChip({required this.skill});
  final Skill skill;

  @override
  State<_SkillChip> createState() => _SkillChipState();
}

class _SkillChipState extends State<_SkillChip> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final s = widget.skill;
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.fromLTRB(8, 8, 14, 8),
        decoration: BoxDecoration(
          color: _hover ? AppColors.soft : AppColors.bg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _hover ? s.color.withValues(alpha: 0.4) : AppColors.border),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              constraints: const BoxConstraints(minWidth: 30),
              height: 30,
              padding: const EdgeInsets.symmetric(horizontal: 6),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: s.color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                s.short,
                style: AppText.body(11.5, color: s.color, weight: FontWeight.w700, height: 1),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              s.name,
              style: AppText.body(14, color: AppColors.ink, weight: FontWeight.w500, height: 1.2),
            ),
          ],
        ),
      ),
    );
  }
}
