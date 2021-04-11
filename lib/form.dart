import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';

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
  TextEditingController dateController = TextEditingController();

  @override
  void dispose() {
    taskController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    dateController.text = DateFormat.yMMMd().format(DateTime.now());
  }

  void addTask(String taskDescription, String deadline) async {
    String deadlineStr = deadline;
    await widget.database.transaction((txn) async {
      String today = DateFormat.yMMMd().format(DateTime.now());
      await txn.rawInsert(
          "INSERT INTO Tasks(description, startdate, enddate) VALUES('$taskDescription', '$today', '$deadlineStr')");
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
            Padding(
              padding: EdgeInsets.all(15),
              child: Text(
                "Add a New Task",
                style: TextStyle(fontSize: 30),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: Text(
                "For tasks that may last longer than your usual workday",
                style: TextStyle(
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            TextFormField(
              controller: taskController,
              decoration: const InputDecoration(
                  icon: Icon(Icons.assignment),
                  hintText: 'What would you like to do today?',
                  labelText: "Task Description"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please fill in this field!';
                }
                return null;
              },
            ),
            TextFormField(
              key: Key(dateController.text),
              controller: dateController,
              decoration: const InputDecoration(
                icon: Icon(Icons.calendar_today),
                labelText: "Choose a due date",
              ),
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
                showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2050),
                  errorFormatText: "Date is incorrectly formatted!",
                  errorInvalidText: "Invalid date!",
                ).then((value) => setState(() {
                      dateController.text = DateFormat.yMMMd().format(value);
                    }));
              },
            ),
            Padding(
              padding: EdgeInsets.all(30),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.pink[200]),
                  padding: MaterialStateProperty.all(
                    EdgeInsets.fromLTRB(25, 15, 25, 15),
                  ),
                ),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    addTask(taskController.text, dateController.text);
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text('Added task!')));
                  }
                  Navigator.pop(context);
                },
                child: Text('Submit', style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
