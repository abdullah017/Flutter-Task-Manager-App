import 'package:flutter/material.dart';


class AddTaskButton extends StatelessWidget {
  final String label;
  final Function()? onPress;
  const AddTaskButton({
    Key? key,
    required this.label,
    required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(label),
      onPressed: onPress,
    );
  }
}
