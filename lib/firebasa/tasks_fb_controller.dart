

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yehyefirebasee/models/fb/task_model.dart';

class TasksFbController{

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String table= 'tasks';
  ///Create
  Future<bool> create(TaskModel task) async{
   await _firestore.collection(table).doc(task.id).set(task.toJson())
       .catchError((onError) => false
   );
   return true;
  }
  ///Read
  Stream<QuerySnapshot<TaskModel>> read() async*{
    yield* _firestore.collection(table)
        .withConverter<TaskModel>(
        fromFirestore: (snapshot, options) {
          ///From Json => Model
          return TaskModel.fromJson(snapshot.data()!);
        },
        toFirestore: (value, options) {
          /// To Json => Map
          return value.toJson();
        },)

        .snapshots();
  }
  ///Update
  Future<bool> update(TaskModel task) async{
    await _firestore.collection(table)
        .doc(task.id)
        .update(task.toJson())
        .catchError((onError)=>false);
    return true;
  }
  ///Delete
  Future<bool> delete(TaskModel task) async{
    await _firestore.collection(table)
        .doc(task.id)
        .delete()
        .catchError((onError)=>false);
    return true;
  }

}