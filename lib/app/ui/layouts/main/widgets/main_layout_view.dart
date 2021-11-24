import 'package:flutter/material.dart';
class MainLayoutView extends StatelessWidget {
  final Widget child;

  const MainLayoutView({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: child);
  }
}

