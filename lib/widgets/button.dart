import 'package:flutter/material.dart';
import 'package:todo_list/config/theme.dart';

class MyButton extends StatelessWidget {
  final String label;
  final Function()? onTap;
  const MyButton({super.key, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          width: 100,
          height: 50,
          alignment: AlignmentDirectional.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: primaryColor),
          child: Text(
            label,
            style: TextStyle(color: white, fontWeight: FontWeight.bold),
          ),
        ));
  }
}
