import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taskie/models/task.dart';

class DatabaseService {

  // User id, use to create a specific collection
  // Store tasks
  final String uid;
  DatabaseService({required this.uid});

  // Collection reference
  final CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');
  // Update user information in collection
  Future updateUserData(String name, String email) async {
    return await usersCollection.doc(uid).set({
      'name': name,
      'email': email,
    })
    .then((value) => print("User Added"))
    .catchError((error) => print("Failed to add user: $error"));
  }

  // Add task to collection
  Future addTask(String description, String created) async {
    final CollectionReference taskCollection = FirebaseFirestore.instance.collection('users').doc(uid).collection('tasks');

    return await taskCollection.add({
      'uid' : null,
      'description': description,
      'created': created,
    })
    .then((docRef) {
      taskCollection.doc(docRef.id).update({'uid': docRef.id});
      print("Task Added");
    })
    .catchError((error) => print("Failed to add task: $error"));
  }

  //Delete task from collection
  Future deleteTask(String tid) async {
    final CollectionReference taskCollection = FirebaseFirestore.instance.collection('users').doc(uid).collection('tasks');

    return await taskCollection.doc(tid).delete()
    .then((value) => print("Task Delete"))
    .catchError((error) => print("Failed to delete task: $error"));
  }

  // Task list from snapshot
  List<Task> _taskListFromSnapshot(QuerySnapshot snapshot) {
    try {
      return snapshot.docs.map((doc) {
        return Task(
          uid: doc.get("uid") ?? "",
          description: doc.get("description") ?? "",
          created: doc.get("created") ?? "0",
        );
      }).toList();
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  // Get task doc stream
  Stream<List<Task>> get tasks {
    return usersCollection.doc(uid).collection('tasks').snapshots()
        .map(_taskListFromSnapshot);
  }
}