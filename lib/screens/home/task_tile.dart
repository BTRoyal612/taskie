import 'package:flutter/material.dart';
import 'package:taskie/models/task.dart';

class TaskTile extends StatelessWidget {

  final Task task;
  TaskTile({required this.task});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          title: Text(task.description),
          subtitle: Text(task.created.toString()),
        ),
      ),
    );
  }
}
