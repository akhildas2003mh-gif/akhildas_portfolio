import 'package:flutter/material.dart';

import '../data/portfolio_data.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final desktop = Responsive.isDesktop(context);
    final tablet = Responsive.isTablet(context);

    final text = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Reveal(child: SectionTitle(plain: 'About', accent: 'Me')),
        const SizedBox(height: 22),
        for (final p in Profile.aboutParagraphs) ...[
          Reveal(child: Text(p, style: AppText.body(16.5))),
          const SizedBox(height: 14),
        ],
        Reveal(
          child: Text(
            Profile.objective,
            style: AppText.body(16.5, color: AppColors.ink, weight: FontWeight.w500),
          ),
        ),
        const SizedBox(height: 20),
        Reveal(
          child: Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [for (final i in Profile.interests) TagChip(i)],
          ),
        ),
      ],
    );

    const info = Reveal(delay: Duration(milliseconds: 150), child: _InfoCard());

    if (desktop) {
      return SectionShell(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(flex: 5, child: text),
            const SizedBox(width: 48),
            const Expanded(flex: 4, child: info),
            const SizedBox(width: 32),
            const Expanded(flex: 3, child: _PhoneMock()),
          ],
        ),
      );
    }
    return SectionShell(
      child: tablet
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: text),
                const SizedBox(width: 32),
                const Expanded(child: info),
              ],
            )
          : Column(children: [text, const SizedBox(height: 28), info]),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard();

  @override
  Widget build(BuildContext context) {
    return HoverLift(
      padding: const EdgeInsets.all(26),
      child: Column(
        children: const [
          _InfoRow(icon: Icons.person_rounded, label: 'Name', value: Profile.name),
          _InfoRow(icon: Icons.location_on_rounded, label: 'Location', value: Profile.location),
          _InfoRow(icon: Icons.mail_rounded, label: 'Email', value: Profile.email),
          _InfoRow(icon: Icons.school_rounded, label: 'Training', value: 'Luminar Technolab', last: true),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.icon, required this.label, required this.value, this.last = false});
  final IconData icon;
  final String label;
  final String value;
  final bool last;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: last ? 0 : 20),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(color: AppColors.soft, borderRadius: BorderRadius.circular(12)),
            child: Icon(icon, color: AppColors.primary, size: 22),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: AppText.body(13, height: 1.3)),
                const SizedBox(height: 2),
                SelectableText(
                  value,
                  style: AppText.body(16, color: AppColors.ink, weight: FontWeight.w600, height: 1.3),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Decorative phone with the Flutter logo, echoing the reference design.
class _PhoneMock extends StatelessWidget {
  const _PhoneMock();

  @override
  Widget build(BuildContext context) {
    return Reveal(
      delay: const Duration(milliseconds: 250),
      child: SizedBox(
        height: 380,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.soft,
                borderRadius: BorderRadius.circular(90),
              ),
              width: 230,
              height: 300,
            ),
            Floating(
              child: Transform.rotate(
                angle: 0.08,
                child: Container(
                  width: 168,
                  height: 340,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(34),
                    border: Border.all(color: const Color(0xFF9DB7DE), width: 6),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.22),
                        blurRadius: 36,
                        offset: const Offset(0, 22),
                      ),
                    ],
                  ),
                  child: const Center(child: FlutterLogo(size: 86)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
