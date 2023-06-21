import 'package:app2/modules/contact/add_contact_page.dart';
import 'package:app2/modules/contact/change_language_page.dart';
import 'package:app2/modules/contact/contact_details_page.dart';
import 'package:app2/modules/contact/contact_page.dart';
import 'package:app2/modules/contact/contact_qr_page.dart';
import 'package:app2/modules/contact/edit_contact_page.dart';
import 'package:app2/modules/login/login_page.dart';
import 'package:app2/splashscreen/splashscreen.dart';
import 'package:get/get.dart';

class GetPageRoutes {
  static const String splashScreen = '/';
  static const String login = '/login';
  static const String main = '/main';
  static const String contact = '/contact';
  static const String addContact = '/contact/add';
  static const String editContact = '/contact/edit';
  static const String contactDetails = '/contact/details';
  static const String contactQr = '/contact/details/Qrcode';
  static const String changeLanguage = '/contact/change_lanaguage';

  static List<GetPage> routes() {
    return [
      GetPage(name: splashScreen, page: () => const SplashScreenPage()),
      GetPage(name: login, page: () => const LoginPage()),
      GetPage(name: contact, page: () => const ContactPage()),
      GetPage(name: addContact, page: () => const AddContactPage()),
      GetPage(name: contactDetails, page: () => const ContactDetailsPage()),
      GetPage(name: editContact, page: () => const EditContactPage()),
      GetPage(name: contactQr, page: () => const ContactQrPage()),
      GetPage(name: changeLanguage, page: ()=> const ChangeLanguagePage()),
    ];
  }
}
