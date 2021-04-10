import 'package:flutter/material.dart';

class CustomForm extends StatefulWidget {
  @override
  CustomFormState createState() {
    return CustomFormState();
  }
}

class CustomFormState extends State<CustomForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
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
          )
        ],
      ),
    );
  }
}
