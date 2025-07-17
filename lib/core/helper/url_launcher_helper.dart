import 'package:url_launcher/url_launcher.dart';

class UrlLauncherHelper {
  static Future<void> launchInBrowser(String url) async {
    if (!await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  static Future<void> sendMessageToPhoneWhatsApp(
      String phone, String message) async {
    String formattedPhone = phone;

    // 1. Remove any leading '+' if present (though your example '010...' doesn't have it)
    if (formattedPhone.startsWith('+')) {
      formattedPhone = formattedPhone.substring(1);
    }

    // 2. Handle Egyptian local numbers starting with '0'
    // If the number starts with '0' and is a typical Egyptian mobile length (e.g., 11 digits after '0')
    // We assume it's a local Egyptian number and prepend '20' (Egypt's country code).
    // Example: '01024086054' -> '201024086054'
    if (formattedPhone.startsWith('0') && formattedPhone.length == 11) {
      // 0 + 10 digits
      formattedPhone =
          '20${formattedPhone.substring(1)}'; // Removes '0' and adds '20'
    }
    // You might want to add more robust validation here if you expect
    // other international formats or want to be super strict.
    // For simplicity, this handles the '010...' case for Egypt.

    final Uri whatsappUri = Uri.https(
      'wa.me',
      formattedPhone, // The properly formatted international phone number
      {'text': message}, // The message as a query parameter
    );

    if (!await launchUrl(whatsappUri, mode: LaunchMode.externalApplication)) {
      // If it fails to launch, it means either WhatsApp isn't installed
      // or there's another issue. You can provide more specific feedback.
      throw Exception(
          'Could not launch WhatsApp. Make sure it\'s installed and updated.');
    }
  }
}
