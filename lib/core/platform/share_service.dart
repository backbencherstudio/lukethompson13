import 'dart:io';

import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class ShareService {
  const ShareService();

  Future<void> shareText(String text) async {
    await SharePlus.instance.share(ShareParams(text: text));
  }

  Future<void> shareFile(String path) async {
    await SharePlus.instance.share(ShareParams(files: [XFile(path)]));
  }

  Future<void> sendSms({required String body, String? phoneNumber}) async {
    final encodedBody = Uri.encodeComponent(body);

    final uri = Uri.parse('sms:?body=$encodedBody');

    if (!await launchUrl(uri)) {
      throw Exception('Could not launch SMS app');
    }
  }

  static Future<void> openNativeMap({
    required double latitude,
    required double longitude,
  }) async {
    final uri = Platform.isIOS
        ? Uri.parse('http://maps.apple.com/?ll=$latitude,$longitude')
        : Uri.parse('geo:$latitude,$longitude');

    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not open map.');
    }
  }
}
