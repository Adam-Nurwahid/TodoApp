import 'package:flutter/material.dart';
import 'package:to_do_app/util/my_button.dart';
import 'package:hive/hive.dart';

class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

   DialogBox({super.key,
    required this.controller,
   required this.onSave,
   required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow,
      content: Container(
          height: 120,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
        TextField(
          controller: controller ,
          decoration: const InputDecoration(border:
          OutlineInputBorder(),
          hintText: "Add a New Task"
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
          MyButton(text: "Save", onPressed: onSave),

           const SizedBox(width: 8),

          MyButton(text: "Cancel", onPressed: onCancel),
        ],)

        ],),),
    );
  }
}
