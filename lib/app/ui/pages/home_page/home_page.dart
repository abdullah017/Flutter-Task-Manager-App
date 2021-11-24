import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:intl/intl.dart';
import 'package:taskmanager_app/app/data/services/theme_service.dart';
import 'package:taskmanager_app/app/ui/constants/colors_constant.dart';
import 'package:taskmanager_app/app/ui/theme/themes.dart';
import 'package:taskmanager_app/app/ui/widgets/addtaskButton_widget.dart';

import '../../layouts/main/widgets/main_layout_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/home_controller.dart';

class HomePage extends GetView<HomeController> {
  final _controller = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return MainLayoutView(
      child: Scaffold(
        appBar: _appBar(context),
        body: Obx(
          () => _controller.isLoading.isFalse
              ? Column(
                  children: [
                    _addTaskBar(),
                    _addDateBar(),
                  ],
                )
              : const CircularProgressIndicator(),
        ),
      ),
    );
  }

  _addDateBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DatePicker(
        DateTime.now(),
        height: 100,
        width: 80,
        initialSelectedDate: DateTime.now(),
        selectionColor: AppColor.primaryClr,
        selectedTextColor: AppColor.white,
        dateTextStyle: dateStyle,
        dayTextStyle: dayStyle,
        monthTextStyle: monthStyle,
        onDateChange: (date) {
          _controller.selectedDateTime = date;
        },
      ),
    );
  }

  _addTaskBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat.yMMMMd().format(
                  DateTime.now(),
                ),
                style: subHeadingStyle,
              ),
              Text(
                "TODAY",
                style: headingStyle,
              )
            ],
          ),
          AddTaskButton(
            label: "+ Görev Ekle",
            onPress: () => Get.toNamed("/addTask"),
          ),
        ],
      ),
    );
  }

  _appBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
      leading: GestureDetector(
        onTap: () {
          ThemeService().changeThemeMode();
          _controller.notifyHelper.displayNotification(
              title: "THEME CHANGED",
              body: Get.isDarkMode
                  ? "LIGHT THEME ACTIVATED"
                  : "DARK THEME ACTIVATED");

          _controller.notifyHelper.scheduledNotification();
        },
        child: Icon(
          Get.isDarkMode ? Icons.wb_sunny_outlined : Icons.nightlight_round,
          size: 20,
          color: Get.isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      actions: const [
        CircleAvatar(
          backgroundColor: Colors.amberAccent,
        ),
        SizedBox(
          width: 20,
        )
      ],
    );
  }
}
