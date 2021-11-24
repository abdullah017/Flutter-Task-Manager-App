import '../../controllers/navigation_controller.dart';
import '../../controllers/main_controller.dart';
import 'package:get/get.dart';

class DependecyInjection {
  static void init() {
    Get.put<NavigationController>(NavigationController());
    Get.put<MainController>(MainController());
  }
}