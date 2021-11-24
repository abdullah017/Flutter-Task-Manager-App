import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskmanager_app/app/ui/theme/themes.dart';

class InputField extends StatelessWidget {
  final String title;
  final String hint;

  final TextEditingController? controller;
  final Widget? widget;
  const InputField({
    Key? key,
    required this.title,
    required this.hint,
    this.controller,
    this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 5),
          child: Text(
            title,
            style: subTitleStyle,
          ),
        ),
        TextFormField(
          readOnly: widget == null ? false : true,
          decoration: _inputDecoration(context),
          cursorColor: Get.isDarkMode ? Colors.grey[100] : Colors.grey,
          controller: controller,
          style: subTitleStyle,
        ),
      ],
    );
  }

  _inputDecoration(BuildContext context) {
    return InputDecoration(
      suffixIcon: widget,
      hintText: hint,
      hintStyle: subTitleStyle,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide(color: context.theme.backgroundColor, width: 0),
      ),
    );
  }
}
