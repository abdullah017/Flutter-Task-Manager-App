import 'package:get/get.dart';
import 'package:taskmanager_app/app/controllers/addtask_controller.dart';

class AddTaskBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddTaskController>(() => AddTaskController());
    // Get.put<HomeController>(HomeController());
  }
}
