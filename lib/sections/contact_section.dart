import 'package:flutter/material.dart';

import '../data/portfolio_data.dart';
import '../theme/app_theme.dart';
import '../utils/launcher.dart';
import '../widgets/common.dart';
import '../widgets/social_button.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final desktop = !Responsive.isMobile(context) && Responsive.width(context) >= 900;

    final info = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Reveal(child: SectionTitle(plain: 'Contact', accent: 'Me')),
        const SizedBox(height: 20),
        Reveal(
          child: Text(
            'Feel free to reach out for collaborations, opportunities or just a friendly hello. '
            "I'm currently open to fresher Flutter Developer roles.",
            style: AppText.body(16.5),
          ),
        ),
        const SizedBox(height: 24),
        Reveal(
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: () => openMail(),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.mail_rounded, color: AppColors.primary),
                const SizedBox(width: 12),
                Text(
                  Profile.email,
                  style: AppText.body(16, color: AppColors.ink, weight: FontWeight.w600, height: 1.3),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        Reveal(
          child: Row(
            children: [
              for (final link in Socials.all) ...[
                SocialButton(link: link, filled: true, size: 48),
                const SizedBox(width: 14),
              ],
            ],
          ),
        ),
      ],
    );

    const form = Reveal(delay: Duration(milliseconds: 150), child: _ContactForm());

    return SectionShell(
      color: Colors.white,
      child: desktop
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 4, child: info),
                Container(
                  width: 1,
                  height: 380,
                  margin: const EdgeInsets.symmetric(horizontal: 44),
                  color: AppColors.border,
                ),
                const Expanded(flex: 6, child: form),
              ],
            )
          : Column(children: [info, const SizedBox(height: 36), form]),
    );
  }
}

class _ContactForm extends StatefulWidget {
  const _ContactForm();

  @override
  State<_ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<_ContactForm> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _subject = TextEditingController();
  final _message = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _subject.dispose();
    _message.dispose();
    super.dispose();
  }

  String? _required(String? v, String label) =>
      (v == null || v.trim().isEmpty) ? 'Please enter $label' : null;

  String? _validateEmail(String? v) {
    if (v == null || v.trim().isEmpty) return 'Please enter your email';
    final ok = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(v.trim());
    return ok ? null : 'Please enter a valid email';
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    // No backend: compose an email in the visitor's mail app.
    openMail(
      subject: _subject.text.trim(),
      body: 'Hi ${Profile.firstName},\n\n${_message.text.trim()}\n\n'
          '${_name.text.trim()}\n${_email.text.trim()}',
    );
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Opening your email app to send the message…')),
    );
  }

  InputDecoration _decoration(String label) {
    OutlineInputBorder border(Color c, [double w = 1]) => OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: c, width: w),
        );
    return InputDecoration(
      labelText: label,
      labelStyle: AppText.body(14, height: 1.2),
      filled: true,
      fillColor: AppColors.bg,
      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
      enabledBorder: border(AppColors.border),
      focusedBorder: border(AppColors.primary, 1.6),
      errorBorder: border(const Color(0xFFD92D20)),
      focusedErrorBorder: border(const Color(0xFFD92D20), 1.6),
    );
  }

  @override
  Widget build(BuildContext context) {
    final stacked = Responsive.width(context) < 560;
    final nameField = TextFormField(
      controller: _name,
      textInputAction: TextInputAction.next,
      autofillHints: const [AutofillHints.name],
      decoration: _decoration('Your Name'),
      validator: (v) => _required(v, 'your name'),
    );
    final emailField = TextFormField(
      controller: _email,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      autofillHints: const [AutofillHints.email],
      decoration: _decoration('Your Email'),
      validator: _validateEmail,
    );

    return Form(
      key: _formKey,
      child: Column(
        children: [
          if (stacked) ...[
            nameField,
            const SizedBox(height: 16),
            emailField,
          ] else
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: nameField),
                const SizedBox(width: 16),
                Expanded(child: emailField),
              ],
            ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _subject,
            textInputAction: TextInputAction.next,
            decoration: _decoration('Subject'),
            validator: (v) => _required(v, 'a subject'),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _message,
            minLines: 5,
            maxLines: 8,
            decoration: _decoration('Your Message').copyWith(alignLabelWithHint: true),
            validator: (v) => _required(v, 'a message'),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: AppButton(
              label: 'Send Message',
              icon: Icons.send_rounded,
              onPressed: _submit,
            ),
          ),
        ],
      ),
    );
  }
}
