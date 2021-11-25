import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:taskmanager_app/app/data/helpers/db_helper.dart';
import 'package:taskmanager_app/app/data/models/task_model.dart';

class AddTaskController extends GetxController {
  //INPUT VARIABLE
  final TextEditingController titleController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  ////////////////////////////////////////////////////////////////////////
  var taskList = <Task>[].obs;

  //DATE-DATETIME VARIABLE
  Rx<DateTime> selectedDate = DateTime.now().obs;
  DateTime? pickerDate;
  RxBool isLoading = false.obs;
  RxString startTime =
      DateFormat("hh:mm a").format(DateTime.now()).toString().obs;
  RxString endTime =
      DateFormat("hh:mm a").format(DateTime.now()).toString().obs;
  RxString? formattedDate = "".obs;
  var pickedTime;
  ////////////////////////////////////////////////////////////////////////
// REMIND VARIABLE
  RxInt selectedRemind = 5.obs;
  RxList<int> remindList = [5, 10, 15, 20, 30].obs;
  ////////////////////////////////////////////////////////////////////////
// REPEAT VARIABLE
  RxString selectedRepeat = "Günlük".obs;
  RxList<String> repeatList = ["Yok", "Günlük", "Haftalık", "Aylık"].obs;
  ////////////////////////////////////////////////////////////////////////
// COLOR VARIABLE
  RxInt selectedColor = 0.obs;
  ////////////////////////////////////////////////////////////////////////
//OVVERIDE FUNCTIONS
  @override
  void onInit() {
    super.onInit();
    selectedDate;
  }

  ////////////////////////////////////////////////////////////////////////
//DATE-DATETIME FUNCTIONS
  getDateFromUser(BuildContext context) async {
    pickerDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime(2022),
    );
    if (pickerDate != null) {
      selectedDate.value = pickerDate!;
    } else {
      print("BURASI BOŞ");
    }
  }

  getTimeFromUser(BuildContext context, bool isStartTime) async {
    pickedTime = await showTimePicker(
      context: context,
      initialEntryMode: TimePickerEntryMode.input,
      initialTime: TimeOfDay(
        hour: int.parse(startTime.split(":")[0]),
        minute: int.parse(startTime.split(":")[1].split(" ")[0]),
      ),
    );
    formattedDate!.value = pickedTime.format(context);
    if (pickedTime == null) {
      print("İPTAL");
    } else if (isStartTime == true) {
      startTime.value = formattedDate!.value;
    } else if (isStartTime == false) {
      endTime.value = formattedDate!.value;
    }
  }

// ADD DATA TO DB FUNCTIONS
  Future<int?> addTask({Task? task}) async {
    return await DBHelper.insert(task);
  }

  addTaskToDb() async {
    int? value = await addTask(
      task: Task(
        note: noteController.text,
        title: titleController.text,
        date: DateFormat.yMd().format(selectedDate.value),
        startTime: startTime.value,
        endTime: endTime.value,
        remind: selectedRemind.value,
        repeat: selectedRepeat.value,
        color: selectedColor.value,
        isCompleted: 0,
      ),
    );
    print("OLUŞTURULAN SATIRIN ID DEĞER:" + "$value");
  }

// VALIDATE FORM FUNCTION
  validateForm() {
    if (titleController.text.isNotEmpty && noteController.text.isNotEmpty) {
      addTaskToDb();
      Get.back();
    } else if (titleController.text.isEmpty || noteController.text.isEmpty) {
      Get.snackbar(
        "HATA",
        "Tüm alanların doldurulması gereklidir!",
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  void showLoading() => isLoading.toggle();

  void hideLoading() => isLoading.toggle();
}
