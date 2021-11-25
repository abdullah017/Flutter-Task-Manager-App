// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:get/get.dart';
import 'package:taskmanager_app/app/data/helpers/db_helper.dart';
import 'package:taskmanager_app/app/data/models/task_model.dart';
import 'package:taskmanager_app/app/data/services/notification_service.dart';

class HomeController extends GetxController {
  Rx<DateTime> selectedDateTime = DateTime.now().obs;
  var notifyHelper;
  RxBool isLoading = false.obs;
  var taskList = <Task>[].obs;
  @override
  void onReady() {
    getTasks();
    super.onReady();
  }

  @override
  void onInit() {
    super.onInit();
    notifyHelper = NotificationHelper();
    notifyHelper.initializeNotification();
  }

  void getTasks() async {
    List<Map<String, dynamic>> tasks = await DBHelper.query();
    taskList.assignAll(tasks.map((data) => new Task.fromJson(data)).toList());
  }

  void delete(Task task) {
    DBHelper.delete(task);
    getTasks();
  }

  void updateTask(int id) async {
    await DBHelper.update(id);
    getTasks();
  }

  void showLoading() => isLoading.toggle();

  void hideLoading() => isLoading.toggle();
}
