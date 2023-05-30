import 'package:app2/modules/contact/add_contact_page.dart';
import 'package:app2/modules/contact/contact_details_page.dart';
import 'package:app2/modules/contact/contact_page.dart';
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

  static List<GetPage> routes() {
    return [
      GetPage(name: splashScreen, page: () => SplashScreenPage()),
      GetPage(name: login, page: () => LoginPage()),
      GetPage(name: contact, page: () => ContactPage()),
      GetPage(name: addContact, page: () => AddContactPage()),
      GetPage(name: contactDetails, page: () => ContactDetailsPage()),
    ];
  }
}
