import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class ShareService {
  const ShareService();

  Future<void> share(String text) async {
    await SharePlus.instance.share(ShareParams(text: text));
  }

  Future<void> sendSms({required String body, String? phoneNumber}) async {
    final encodedBody = Uri.encodeComponent(body);

    final uri = Uri.parse('sms:?body=$encodedBody');

    if (!await launchUrl(uri)) {
      throw Exception('Could not launch SMS app');
    }
  }
}
