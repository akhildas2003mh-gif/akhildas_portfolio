import 'package:url_launcher/url_launcher.dart';

import '../data/portfolio_data.dart';

Future<void> openUrl(String url) async {
  await launchUrl(
    Uri.parse(url),
    mode: LaunchMode.externalApplication,
    webOnlyWindowName: '_blank',
  );
}

Future<void> openMail({String? subject, String? body}) {
  final params = <String>[
    if (subject != null && subject.isNotEmpty) 'subject=${Uri.encodeComponent(subject)}',
    if (body != null && body.isNotEmpty) 'body=${Uri.encodeComponent(body)}',
  ];
  final query = params.isEmpty ? '' : '?${params.join('&')}';
  return openUrl('mailto:${Profile.email}$query');
}

Future<void> openResume() =>
    openUrl(Uri.base.resolve(Profile.resumePath).toString());
