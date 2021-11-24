// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:get/get.dart';
import 'package:taskmanager_app/app/data/services/notification_service.dart';

class HomeController extends GetxController {
  DateTime selectedDateTime = DateTime.now();
  var notifyHelper;
  RxBool isLoading = false.obs;
  @override
  void onInit() {
    super.onInit();
    notifyHelper = NotificationHelper();
    notifyHelper.initializeNotification();
  }

  void showLoading() => isLoading.toggle();

  void hideLoading() => isLoading.toggle();
}
