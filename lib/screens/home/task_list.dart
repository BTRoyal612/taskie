import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskie/models/task.dart';
import 'package:taskie/screens/home/task_tile.dart';
import 'package:taskie/services/database.dart';
import 'package:taskie/models/user.dart';

class TaskList extends StatefulWidget {
  const TaskList({Key? key}) : super(key: key);

  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<taskieUser?>(context);
    final tasks = Provider.of<List<Task>>(context);

    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        return Dismissible(
          background: Container(
            color: Colors.green,
          ),
          key: ValueKey<Task>(tasks[index]),
          onDismissed: (DismissDirection direction) {
            setState(() {
              DatabaseService(uid: user!.uid).deleteTask(tasks[index].uid);
              tasks.removeAt(index);
            });
          },
          child: TaskTile(task: tasks[index]),
        );
      },
    );
  }
}
