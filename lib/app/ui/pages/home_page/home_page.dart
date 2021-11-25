import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';
import 'package:taskmanager_app/app/data/models/task_model.dart';
import 'package:taskmanager_app/app/data/services/theme_service.dart';
import 'package:taskmanager_app/app/ui/constants/colors_constant.dart';
import 'package:taskmanager_app/app/ui/theme/themes.dart';
import 'package:taskmanager_app/app/ui/widgets/addtaskButton_widget.dart';
import 'package:taskmanager_app/app/ui/widgets/task_tile_widget.dart';

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
                    _showTasks(),
                  ],
                )
              : const CircularProgressIndicator(),
        ),
      ),
    );
  }

  _bottomShetButton(
      {required String label,
      required Function()? onTap,
      required Color clr,
      bool isClose = false,
      required BuildContext context}) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 4),
          height: 55,
          width: MediaQuery.of(context).size.width * 0.9,
          // color: isClose == true ? Colors.red : clr,
          decoration: BoxDecoration(
            border: Border.all(
                width: 2,
                color: isClose == true
                    ? Get.isDarkMode
                        ? Colors.grey[600]!
                        : Colors.grey[300]!
                    : clr),
            borderRadius: BorderRadius.circular(18),
            color: isClose == true ? Colors.transparent : clr,
          ),
          child: Center(
            child: Text(label,
                style: isClose
                    ? titleStyle
                    : titleStyle.copyWith(color: Colors.white)),
          ),
        ));
  }

  _showBottomShet(BuildContext context, Task task) {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.only(top: 4),
        height: task.isCompleted == 1
            ? MediaQuery.of(context).size.height * 0.24
            : MediaQuery.of(context).size.height * 0.32,
        color: Get.isDarkMode ? AppColor.darkGreyClr : AppColor.white,
        child: Column(
          children: [
            Container(
              height: 6,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Get.isDarkMode ? Colors.grey[600] : Colors.grey[300],
              ),
            ),
            Spacer(),
            task.isCompleted == 1
                ? Container()
                : _bottomShetButton(
                    label: "Görev Tamamlandı",
                    onTap: () {
                      _controller.updateTask(task.id!);

                      Get.back();
                    },
                    clr: AppColor.primaryClr,
                    context: context,
                  ),
            SizedBox(height: 10),
            _bottomShetButton(
              label: "Görevi Sil",
              onTap: () {
                _controller.delete(task);

                Get.back();
              },
              clr: Colors.red,
              context: context,
            ),
            SizedBox(height: 10),
            _bottomShetButton(
              label: "Kapat",
              onTap: () {
                Get.back();
              },
              clr: Colors.grey,
              isClose: true,
              context: context,
            )
          ],
        ),
      ),
    );
  }

  _showTasks() {
    return Expanded(
      child: ListView.builder(
        itemCount: _controller.taskList.length,
        itemBuilder: (_, index) {
          print(_controller.taskList.length);
          Task task = _controller.taskList[index];
          print(task.toJson());
          print(DateFormat.yMd().format(_controller.selectedDateTime.value));
          if (task.repeat == "Günlük" || task.repeat == "Yok") {
            return AnimationConfiguration.staggeredList(
              position: index,
              child: SlideAnimation(
                child: FadeInAnimation(
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          _showBottomShet(_, task);
                        },
                        child: TaskTile(task),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          if (task.date ==
              DateFormat.yMd().format(_controller.selectedDateTime.value)) {
            return AnimationConfiguration.staggeredList(
              position: index,
              child: SlideAnimation(
                child: FadeInAnimation(
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          _showBottomShet(_, task);
                        },
                        child: TaskTile(task),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Container();
          }
        },
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
          _controller.selectedDateTime.value = date;
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
              onPress: () async {
                await Get.toNamed("/addTask");
                _controller.getTasks();
              }),
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
    );
  }
}
