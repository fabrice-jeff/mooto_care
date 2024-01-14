import 'package:autocare/utils/share_preference.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../../../datas/models/acteur.dart';

class HomeController extends GetxController {
  Acteur? acteur = SharePreferences.getActeur();
}
