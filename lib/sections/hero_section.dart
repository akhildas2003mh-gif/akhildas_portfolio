import 'package:flutter/material.dart';

import '../data/portfolio_data.dart';
import '../theme/app_theme.dart';
import '../utils/launcher.dart';
import '../widgets/common.dart';
import '../widgets/social_button.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key, required this.onProjects, required this.onContact});

  final VoidCallback onProjects;
  final VoidCallback onContact;

  @override
  Widget build(BuildContext context) {
    final desktop = Responsive.isDesktop(context);
    final mobile = Responsive.isMobile(context);
    final text = _HeroText(onProjects: onProjects, onContact: onContact);
    const visual = _HeroVisual();

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.white, AppColors.bg],
        ),
      ),
      child: SectionShell(
        top: 120,
        bottom: mobile ? 56 : 72,
        child: desktop
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(flex: 6, child: text),
                  const SizedBox(width: 24),
                  const Expanded(flex: 5, child: visual),
                ],
              )
            : Column(
                children: [
                  visual,
                  const SizedBox(height: 28),
                  text,
                ],
              ),
      ),
    );
  }
}

class _HeroText extends StatelessWidget {
  const _HeroText({required this.onProjects, required this.onContact});
  final VoidCallback onProjects;
  final VoidCallback onContact;

  @override
  Widget build(BuildContext context) {
    final hello = Responsive.pick(context, mobile: 24.0, tablet: 30.0, desktop: 34.0);
    final big = Responsive.pick(context, mobile: 46.0, tablet: 62.0, desktop: 72.0);
    final mid = Responsive.pick(context, mobile: 36.0, tablet: 48.0, desktop: 56.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Reveal(
          child: Text(
            "Hello, I'm 👋",
            style: AppText.heading(hello, weight: FontWeight.w500),
          ),
        ),
        const SizedBox(height: 6),
        Reveal(
          delay: const Duration(milliseconds: 100),
          child: Semantics(
            header: true,
            child: Text.rich(
              TextSpan(children: [
                TextSpan(text: '${Profile.firstName} ', style: AppText.heading(big, weight: FontWeight.w800)),
                TextSpan(text: Profile.lastName, style: AppText.heading(big, color: AppColors.primary, weight: FontWeight.w800)),
              ]),
            ),
          ),
        ),
        const SizedBox(height: 6),
        Reveal(
          delay: const Duration(milliseconds: 200),
          child: Text.rich(
            TextSpan(children: [
              TextSpan(text: 'Flutter ', style: AppText.heading(mid, color: AppColors.primary, weight: FontWeight.w600)),
              TextSpan(text: 'Developer', style: AppText.heading(mid, weight: FontWeight.w600)),
            ]),
          ),
        ),
        const SizedBox(height: 16),
        Reveal(
          delay: const Duration(milliseconds: 260),
          child: Text(
            'Mobile Application Developer',
            style: AppText.body(15, color: AppColors.primary, weight: FontWeight.w600, height: 1.3),
          ),
        ),
        const SizedBox(height: 14),
        Reveal(
          delay: const Duration(milliseconds: 320),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 540),
            child: Text(Profile.intro, style: AppText.body(Responsive.isMobile(context) ? 16 : 18)),
          ),
        ),
        const SizedBox(height: 28),
        Reveal(
          delay: const Duration(milliseconds: 400),
          child: Wrap(
            spacing: 14,
            runSpacing: 12,
            children: [
              AppButton(label: 'View My Projects', icon: Icons.arrow_forward_rounded, onPressed: onProjects),
              AppButton(label: 'Download Resume', icon: Icons.download_rounded, filled: false, onPressed: openResume),
              AppButton(label: 'Contact Me', icon: Icons.mail_outline_rounded, filled: false, onPressed: onContact),
            ],
          ),
        ),
        const SizedBox(height: 28),
        Reveal(
          delay: const Duration(milliseconds: 480),
          child: Row(
            children: [
              for (final link in Socials.all) ...[
                SocialButton(link: link),
                const SizedBox(width: 12),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _HeroVisual extends StatelessWidget {
  const _HeroVisual();

  @override
  Widget build(BuildContext context) {
    final h = Responsive.pick(context, mobile: 340.0, tablet: 440.0, desktop: 520.0);
    return Reveal(
      delay: const Duration(milliseconds: 150),
      child: SizedBox(
        height: h,
        width: double.infinity,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            // Soft organic blob behind the photo.
            Align(
              alignment: Alignment.bottomCenter,
              child: FractionallySizedBox(
                widthFactor: 0.9,
                heightFactor: 0.88,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFFE3EFFF), Color(0xFFBBD5FF)],
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(h * 0.42),
                      topRight: Radius.circular(h * 0.26),
                      bottomLeft: Radius.circular(h * 0.30),
                      bottomRight: Radius.circular(h * 0.40),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: h * 0.2,
              left: h * 0.1,
              child: Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.cyan.withValues(alpha: 0.7), width: 3),
                ),
              ),
            ),
            Positioned(bottom: 0, child: _ProfileImage(height: h * 0.94)),
            Positioned(
              top: h * 0.02,
              right: 4,
              child: Floating(child: FlutterLogo(size: h * 0.24)),
            ),
          ],
        ),
      ),
    );
  }
}

/// Uses assets/images/profile.png (a transparent-background cut-out looks best).
/// Falls back to an initials avatar until the photo is added.
class _ProfileImage extends StatelessWidget {
  const _ProfileImage({required this.height});
  final double height;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Portrait of ${Profile.name}',
      image: true,
      child: Container(height: 450,width: 450,
      decoration: BoxDecoration(borderRadius: .circular(35),color: Colors.amber) ,
        child: Image.asset(
          'assets/images/akhil_portfolio_profile.jpeg',
          height: height,
          fit: BoxFit.contain,
          errorBuilder: (_, _, _) => SizedBox(
            height: height,
            width: height * 0.75,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: height * 0.62,
                height: height * 0.62,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [AppColors.cyan, AppColors.primary],
                  ),
                ),
                alignment: Alignment.center,
                 
              ),
            ),
          ),
        ),
      ),
    );
  }
}
