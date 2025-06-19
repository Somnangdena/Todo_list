import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_list/config/theme.dart';

class NotifiedPage extends StatelessWidget {
  final String? label;
  const NotifiedPage({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(), icon: Icon(Icons.arrow_back_ios)),
        title: Text(
          label.toString().split("|")[0],
          style: titleStyle,
        ),
      ),
    );
  }
}
