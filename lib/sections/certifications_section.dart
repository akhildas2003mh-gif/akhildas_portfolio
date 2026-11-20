import 'package:flutter/material.dart';

import '../data/portfolio_data.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';

class CertificationsSection extends StatelessWidget {
  const CertificationsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Reveal(
            child: SectionTitle(
              plain: 'My',
              accent: 'Certifications',
              subtitle: 'Verified learning that backs up the skills above.',
            ),
          ),
          const SizedBox(height: 40),
          ResponsiveGrid(
            children: [
              for (var i = 0; i < certifications.length; i++)
                Reveal(
                  delay: Duration(milliseconds: 80 * i),
                  child: _CertCard(cert: certifications[i]),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CertCard extends StatelessWidget {
  const _CertCard({required this.cert});
  final Certification cert;

  @override
  Widget build(BuildContext context) {
    return HoverLift(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 4 / 3,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: cert.imageAsset == null
                  ? const _Placeholder()
                  : Image.asset(
                      cert.imageAsset!,
                      fit: BoxFit.cover,
                      semanticLabel: 'Certificate: ${cert.title}',
                      errorBuilder: (_, _, _) => const _Placeholder(),
                    ),
            ),
          ),
          const SizedBox(height: 16),
          Text(cert.title, style: AppText.heading(16.5, weight: FontWeight.w600).copyWith(height: 1.3)),
          const SizedBox(height: 4),
          Text(cert.issuer, style: AppText.body(14, height: 1.4)),
        ],
      ),
    );
  }
}

class _Placeholder extends StatelessWidget {
  const _Placeholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFF1F6FF), Color(0xFFDDEAFF)],
        ),
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.workspace_premium_rounded, size: 48, color: AppColors.primary),
          const SizedBox(height: 8),
          Text('Certificate image', style: AppText.body(13, weight: FontWeight.w500, height: 1.3)),
        ],
      ),
    );
  }
}
