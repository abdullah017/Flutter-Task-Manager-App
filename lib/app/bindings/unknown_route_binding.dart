
import 'package:get/get.dart';
import '../controllers/unknown_route_controller.dart';


class UnknownRouteBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UnknownRouteController>(() => UnknownRouteController());
        // Get.put<UnknownRouteController>(UnknownRouteController());
  }
}