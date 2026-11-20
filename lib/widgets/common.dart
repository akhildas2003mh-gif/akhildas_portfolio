import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../theme/app_theme.dart';

/// Breakpoints: mobile < 700, tablet < 1080, desktop >= 1080.
class Responsive {
  Responsive._();

  static double width(BuildContext c) => MediaQuery.sizeOf(c).width;
  static bool isMobile(BuildContext c) => width(c) < 700;
  static bool isTablet(BuildContext c) => width(c) >= 700 && width(c) < 1080;
  static bool isDesktop(BuildContext c) => width(c) >= 1080;
  static double hPad(BuildContext c) => isMobile(c) ? 20 : (isTablet(c) ? 32 : 48);

  static T pick<T>(
    BuildContext c, {
    required T mobile,
    T? tablet,
    required T desktop,
  }) {
    if (isMobile(c)) return mobile;
    if (isTablet(c)) return tablet ?? desktop;
    return desktop;
  }
}

/// Centres content in a max-width column with consistent section padding.
class SectionShell extends StatelessWidget {
  const SectionShell({
    super.key,
    required this.child,
    this.color,
    this.top = 88,
    this.bottom = 88,
  });

  final Widget child;
  final Color? color;
  final double top;
  final double bottom;

  @override
  Widget build(BuildContext context) {
    final scale = Responsive.isMobile(context) ? 0.7 : 1.0;
    return Container(
      width: double.infinity,
      color: color,
      padding: EdgeInsets.fromLTRB(
        Responsive.hPad(context),
        top * scale,
        Responsive.hPad(context),
        bottom * scale,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1180),
          child: child,
        ),
      ),
    );
  }
}

/// Small blue bar + two-tone heading, as in the reference design.
class SectionTitle extends StatelessWidget {
  const SectionTitle({
    super.key,
    required this.plain,
    required this.accent,
    this.subtitle,
    this.center = false,
  });

  final String plain;
  final String accent;
  final String? subtitle;
  final bool center;

  @override
  Widget build(BuildContext context) {
    final size = Responsive.pick(context, mobile: 30.0, tablet: 36.0, desktop: 40.0);
    return Column(
      crossAxisAlignment: center ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Container(
          width: 44,
          height: 4,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(height: 14),
        Semantics(
          header: true,
          child: Text.rich(
            textAlign: center ? TextAlign.center : TextAlign.start,
            TextSpan(children: [
              TextSpan(text: '$plain ', style: AppText.heading(size)),
              TextSpan(text: accent, style: AppText.heading(size, color: AppColors.primary)),
            ]),
          ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 12),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: Text(
              subtitle!,
              textAlign: center ? TextAlign.center : TextAlign.start,
              style: AppText.body(16),
            ),
          ),
        ],
      ],
    );
  }
}

/// Fades + slides its child in the first time it scrolls into view.
class Reveal extends StatefulWidget {
  const Reveal({super.key, required this.child, this.delay = Duration.zero});

  final Widget child;
  final Duration delay;

  @override
  State<Reveal> createState() => _RevealState();
}

class _RevealState extends State<Reveal> {
  final _key = UniqueKey();
  bool _shown = false;
  bool _scheduled = false;

  @override
  Widget build(BuildContext context) {
    final reduce = MediaQuery.disableAnimationsOf(context);
    final visible = _shown || reduce;
    return VisibilityDetector(
      key: _key,
      onVisibilityChanged: (info) {
        if (_scheduled || info.visibleFraction < 0.05) return;
        _scheduled = true;
        Future.delayed(widget.delay, () {
          if (mounted) setState(() => _shown = true);
        });
      },
      child: AnimatedOpacity(
        opacity: visible ? 1 : 0,
        duration: const Duration(milliseconds: 650),
        curve: Curves.easeOut,
        child: AnimatedSlide(
          offset: visible ? Offset.zero : const Offset(0, 0.06),
          duration: const Duration(milliseconds: 650),
          curve: Curves.easeOutCubic,
          child: widget.child,
        ),
      ),
    );
  }
}

/// White rounded card that lifts, glows and gains a blue border on hover.
class HoverLift extends StatefulWidget {
  const HoverLift({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(24),
    this.radius = 20,
    this.lift = 6,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final double radius;
  final double lift;

  @override
  State<HoverLift> createState() => _HoverLiftState();
}

class _HoverLiftState extends State<HoverLift> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        transform: Matrix4.translationValues(0, _hover ? -widget.lift : 0, 0),
        padding: widget.padding,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(widget.radius),
          border: Border.all(
            color: _hover ? AppColors.primary.withValues(alpha: 0.35) : AppColors.border,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: _hover ? 0.16 : 0.06),
              blurRadius: _hover ? 32 : 18,
              offset: Offset(0, _hover ? 16 : 8),
            ),
          ],
        ),
        child: widget.child,
      ),
    );
  }
}

/// Gentle looping bob used on the floating Flutter logo / phone mock.
class Floating extends StatefulWidget {
  const Floating({
    super.key,
    required this.child,
    this.amplitude = 10,
    this.duration = const Duration(milliseconds: 3200),
  });

  final Widget child;
  final double amplitude;
  final Duration duration;

  @override
  State<Floating> createState() => _FloatingState();
}

class _FloatingState extends State<Floating> with SingleTickerProviderStateMixin {
  late final AnimationController _c;

  @override
  void initState() {
    super.initState();
    _c = AnimationController(vsync: this, duration: widget.duration)
      ..repeat(reverse: true);
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.disableAnimationsOf(context)) return widget.child;
    return AnimatedBuilder(
      animation: _c,
      child: widget.child,
      builder: (_, child) => Transform.translate(
        offset: Offset(0, -widget.amplitude * Curves.easeInOut.transform(_c.value)),
        child: child,
      ),
    );
  }
}

/// Pill button: filled (primary) or outlined, with trailing icon.
class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    this.icon,
    this.onPressed,
    this.filled = true,
    this.compact = false,
  });

  final String label;
  final IconData? icon;
  final VoidCallback? onPressed;
  final bool filled;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final padding = EdgeInsets.symmetric(
      horizontal: compact ? 20 : 28,
      vertical: compact ? 14 : 18,
    );
    final textStyle = GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 14);
    final content = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label),
        if (icon != null) ...[
          const SizedBox(width: 8),
          Icon(icon, size: 18),
        ],
      ],
    );

    if (filled) {
      return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          padding: padding,
          shape: const StadiumBorder(),
          textStyle: textStyle,
        ).copyWith(
          elevation: WidgetStateProperty.resolveWith(
            (s) => s.contains(WidgetState.hovered) ? 8 : 0,
          ),
          shadowColor: WidgetStatePropertyAll(AppColors.primary.withValues(alpha: 0.5)),
        ),
        child: content,
      );
    }
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.ink,
        padding: padding,
        shape: const StadiumBorder(),
        textStyle: textStyle,
        side: BorderSide(
          color: onPressed == null ? AppColors.border : AppColors.ink,
          width: 1.4,
        ),
      ),
      child: content,
    );
  }
}

class TagChip extends StatelessWidget {
  const TagChip(this.label, {super.key});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.soft,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: AppText.body(12, color: AppColors.primary, weight: FontWeight.w600, height: 1.3),
      ),
    );
  }
}

/// Equal-height card grid: 3 / 2 / 1 columns by default.
class ResponsiveGrid extends StatelessWidget {
  const ResponsiveGrid({
    super.key,
    required this.children,
    this.desktopColumns = 3,
    this.tabletColumns = 2,
    this.spacing = 24,
  });

  final List<Widget> children;
  final int desktopColumns;
  final int tabletColumns;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    final cols = Responsive.pick<int>(
      context,
      mobile: 1,
      tablet: tabletColumns,
      desktop: desktopColumns,
    );
    final rows = <Widget>[];
    for (var i = 0; i < children.length; i += cols) {
      final slice = children.skip(i).take(cols).toList();
      rows.add(
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (var j = 0; j < cols; j++) ...[
                if (j > 0) SizedBox(width: spacing),
                Expanded(child: j < slice.length ? slice[j] : const SizedBox.shrink()),
              ],
            ],
          ),
        ),
      );
      if (i + cols < children.length) rows.add(SizedBox(height: spacing));
    }
    return Column(children: rows);
  }
}
