import 'package:flutter/material.dart';
import 'package:taskie/shared/constants.dart';
import 'package:provider/provider.dart';
import 'package:taskie/models/user.dart';
import 'package:taskie/services/database.dart';
import 'package:intl/intl.dart';

class AddTask extends StatefulWidget {
  const AddTask({Key? key}) : super(key: key);

  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {

  final _formKey = GlobalKey<FormState>();
  String content = "";
  String error = "";
  String created = "";



  @override
  Widget build(BuildContext context) {
    final user = Provider.of<taskieUser?>(context);
    DateTime now = new DateTime.now();
    created = DateFormat('yMd').format(now);
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Text(
            'Created: ${created.toString()}',
            style: TextStyle(fontSize: 18.0),
          ),
          SizedBox(height: 20.0),
          TextFormField(
            decoration: taskInputDecoration.copyWith(hintText: 'Task'),
            validator: (val) =>
            val!.length > 100
                ? 'Please enter simple task'
                : null,
            onChanged: (val) => setState(() => content = val),
          ),
          SizedBox(height: 20.0),
          ElevatedButton(
            child: const Text(
              'Add',
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.pink[400],
            ),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                setState(() {
                  DatabaseService(uid: user!.uid).addTask(content, created);
                });
                Navigator.pop(context);
              }
            },
          ),
          SizedBox(height: 12.0),
          Text(
            error,
            style: TextStyle(color: Colors.red, fontSize: 14.0),
          )
        ],
      ),
    );
  }
}
