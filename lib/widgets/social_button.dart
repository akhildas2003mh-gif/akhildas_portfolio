import 'package:flutter/material.dart';

import '../data/portfolio_data.dart';
import '../theme/app_theme.dart';
import '../utils/launcher.dart';

/// Circular social button. [filled] = brand-coloured (contact section),
/// otherwise a subtle outlined style (hero).
class SocialButton extends StatefulWidget {
  const SocialButton({super.key, required this.link, this.filled = false, this.size = 44});

  final SocialLink link;
  final bool filled;
  final double size;

  @override
  State<SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<SocialButton> {
  bool _hover = false;

  void _tap() {
    final url = widget.link.url;
    if (url == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '${widget.link.label} link not added yet. Set it in lib/data/portfolio_data.dart.',
          ),
        ),
      );
      return;
    }
    openUrl(url);
  }

  @override
  Widget build(BuildContext context) {
    final l = widget.link;
    final bg = widget.filled ? l.color : (_hover ? AppColors.primary : Colors.white);
    final fg = widget.filled || _hover ? Colors.white : AppColors.ink;
    return Tooltip(
      message: l.url == null ? '${l.label} (add your link)' : l.label,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _hover = true),
        onExit: (_) => setState(() => _hover = false),
        child: GestureDetector(
          onTap: _tap,
          child: Semantics(
            button: true,
            label: l.label,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              transform: Matrix4.translationValues(0, _hover ? -3 : 0, 0),
              width: widget.size,
              height: widget.size,
              decoration: BoxDecoration(
                color: bg,
                shape: BoxShape.circle,
                border: widget.filled ? null : Border.all(color: AppColors.border, width: 1.5),
                boxShadow: [
                  BoxShadow(
                    color: (widget.filled ? l.color : AppColors.primary)
                        .withValues(alpha: _hover ? 0.35 : 0.12),
                    blurRadius: _hover ? 18 : 10,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Center(
                child: Icon(l.icon, size: widget.size * 0.42, color: fg),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
