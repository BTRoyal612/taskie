import 'package:taskie/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskie/models/task.dart';
import 'package:taskie/services/database.dart';
import 'package:taskie/models/user.dart';
import 'package:taskie/screens/home/task_list.dart';
import 'package:taskie/screens/home/add_task.dart';



class Home extends StatelessWidget {
  final AuthService _auth = AuthService();



  @override
  Widget build(BuildContext context) {
    final user = Provider.of<taskieUser?>(context);

    void _showAddTaskPanel() {
      showModalBottomSheet<void>(context: context, builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: AddTask(),
        );
      });
    }

    return StreamProvider<List<Task>>.value(
      initialData: const [],
      value: DatabaseService(uid: user!.uid).tasks,
      child: Scaffold(
          backgroundColor: Colors.brown[50],
          appBar: AppBar(
            title: Text('Taskie'),
            backgroundColor: Colors.pinkAccent[200],
            elevation: 0.0,
            actions: <Widget>[
              TextButton.icon(
                  icon: Icon(Icons.person),
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                  ),
                  label: Text('logout'),
                  onPressed: () async {
                    await _auth.signOut();
                  },
              )
            ],
          ),
          body: Container(
              child: TaskList(),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => _showAddTaskPanel(),
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
            backgroundColor: Colors.grey[400],
          ),
        ),
    );
  }
}
