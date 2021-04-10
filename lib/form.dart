import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tempus/main.dart';

class CustomForm extends StatefulWidget {
  CustomForm(this.path, this.database);
  final String path;
  final Database database;

  @override
  CustomFormState createState() {
    return CustomFormState();
  }
}

class CustomFormState extends State<CustomForm> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController taskController = TextEditingController();

  @override
  void dispose() {
    taskController.dispose();
    super.dispose();
  }

  void addTask(String taskDescription) async {
    await widget.database.transaction((txn) async {
      await txn.rawInsert(
          "INSERT INTO Tasks(description) VALUES(\'$taskDescription\')");
    });
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: taskController,
              decoration: const InputDecoration(
                  icon: Icon(Icons.assignment),
                  hintText: 'What would you like to do today?',
                  labelText: "Type in a task"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please fill in this field!';
                }
                return null;
              },
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  addTask(taskController.text);
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('Added task!')));
                }
                Navigator.pop(context);
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
