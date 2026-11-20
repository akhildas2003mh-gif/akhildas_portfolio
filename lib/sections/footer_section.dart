import 'package:flutter/material.dart';

import '../data/portfolio_data.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';
import '../widgets/nav_bar.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key, required this.onNavigate});
  final ValueChanged<SectionId> onNavigate;

  @override
  Widget build(BuildContext context) {
    final mobile = Responsive.isMobile(context);
    final copy = Text.rich(
      TextSpan(
        style: AppText.body(14, height: 1.4),
        children: [
          TextSpan(text: '© ${DateTime.now().year} '),
          TextSpan(
            text: Profile.name,
            style: AppText.body(14, color: AppColors.ink, weight: FontWeight.w700, height: 1.4),
          ),
          const TextSpan(text: '. All Rights Reserved.'),
        ],
      ),
    );
    final links = Wrap(
      spacing: 22,
      runSpacing: 8,
      children: [
        for (final item in navItems.where((n) => const {
              SectionId.home,
              SectionId.about,
              SectionId.projects,
              SectionId.skills,
              SectionId.contact,
            }.contains(n.id)))
          InkWell(
            onTap: () => onNavigate(item.id),
            child: Text(item.label, style: AppText.body(14, color: AppColors.ink, height: 1.4)),
          ),
      ],
    );

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: SectionShell(
        top: 28,
        bottom: 28,
        child: mobile
            ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: [copy, const SizedBox(height: 14), links])
            : Row(
                children: [
                  Flexible(child: copy),
                  const SizedBox(width: 24),
                  Flexible(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: links,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
