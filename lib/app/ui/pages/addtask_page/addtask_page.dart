import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:taskmanager_app/app/controllers/addtask_controller.dart';
import 'package:taskmanager_app/app/ui/constants/colors_constant.dart';
import 'package:taskmanager_app/app/ui/constants/string_constant.dart';
import 'package:taskmanager_app/app/ui/layouts/main/widgets/main_layout_view.dart';
import 'package:taskmanager_app/app/ui/theme/themes.dart';
import 'package:taskmanager_app/app/ui/widgets/addtaskButton_widget.dart';
import 'package:taskmanager_app/app/ui/widgets/inputField_widget.dart';

class AddTaskPage extends GetView<AddTaskController> {
  final _controller = Get.find<AddTaskController>();

  @override
  Widget build(BuildContext context) {
    return MainLayoutView(
        child: Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: _appBar(context),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Obx(
            () => controller.isLoading.isFalse
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppString.addTaskTitle,
                        style: headingStyle,
                      ),
                      _title(),
                      _note(),
                      _date(context),
                      SizedBox(height: 10),
                      _start_end_time(context),
                      _remind(),
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: InputField(
                          title: AppString.inputField_Repeat,
                          hint: "${_controller.selectedRepeat.value}",
                          widget: DropdownButton(
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.grey,
                            ),
                            onChanged: (String? newValue) {
                              _controller.selectedRepeat.value = newValue!;
                            },
                            items: _controller.repeatList
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _colorPallet(),
                          AddTaskButton(
                            label: "Görev Oluştur",
                            onPress: () => _controller.validateForm(),
                          ),
                        ],
                      )
                    ],
                  )
                : CircularProgressIndicator(),
          ),
        ),
      ),
    ));
  }

  Column _colorPallet() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppString.colorTitle,
          style: subTitleStyle,
        ),
        SizedBox(
          height: 10,
        ),
        Wrap(
          children: List<Widget>.generate(
            3,
            (int index) {
              return GestureDetector(
                onTap: () {
                  _controller.selectedColor.value = index;
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: CircleAvatar(
                    radius: 14,
                    backgroundColor: index == 0
                        ? AppColor.primaryClr
                        : index == 1
                            ? AppColor.pinkClr
                            : AppColor.yellowClr,
                    child: _controller.selectedColor == index
                        ? Icon(Icons.done, color: AppColor.white)
                        : Container(),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Container _remind() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: InputField(
        title: AppString.inputField_Remind,
        hint: "${_controller.selectedRemind.value} dakika önce",
        widget: DropdownButton(
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: Colors.grey,
          ),
          onChanged: (String? newValue) {
            _controller.selectedRemind.value = int.parse(newValue!);
          },
          items:
              _controller.remindList.map<DropdownMenuItem<String>>((int value) {
            return DropdownMenuItem<String>(
              value: value.toString(),
              child: Text(value.toString()),
            );
          }).toList(),
        ),
      ),
    );
  }

  Row _start_end_time(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: InputField(
            title: AppString.inputField_StartTime,
            hint: _controller.startTime.value,
            widget: IconButton(
              onPressed: () {
                _controller.getTimeFromUser(context, true);
              },
              icon: Icon(Icons.access_time_rounded),
            ),
          ),
        ),
        SizedBox(
          width: 12,
        ),
        Expanded(
          child: InputField(
            title: AppString.inputField_EndTime,
            hint: _controller.endTime.value,
            widget: IconButton(
              onPressed: () {
                _controller.getTimeFromUser(context, false);
              },
              icon: Icon(Icons.access_time_rounded),
            ),
          ),
        ),
      ],
    );
  }

  Container _date(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: InputField(
        title: AppString.inputField_Date,
        hint: DateFormat.yMd().format(_controller.selectedDate.value),
        widget: IconButton(
          onPressed: () {
            _controller.getDataFromUser(context);
          },
          icon: const Icon(
            Icons.calendar_today_outlined,
          ),
        ),
      ),
    );
  }

  Container _note() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: InputField(
        controller: _controller.noteController,
        title: AppString.inputField_Note,
        hint: AppString.inputField_Note_Hint,
      ),
    );
  }

  Container _title() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: InputField(
        controller: _controller.titleController,
        title: AppString.inputField_Title,
        hint: AppString.inputField_Title_Hint,
      ),
    );
  }

  _appBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
      leading: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Icon(
          Icons.arrow_back_ios,
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
