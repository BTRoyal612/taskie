import 'package:taskie/services/auth.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}
