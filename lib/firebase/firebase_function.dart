import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/task_model.dart';
import 'package:todo_app/user_model.dart';

class FirebaseFunction {
  static CollectionReference<UserModel> getUserCollection() {
    return FirebaseFirestore.instance
        .collection(UserModel.collectionName)
        .withConverter<UserModel>(
      fromFirestore: (snapshot, _) {
        return UserModel.fromJson(snapshot.data()!);
      },
      toFirestore: (task, _) {
        return task.toJson();
      },
    );
  }

  static CollectionReference<TaskModel> getTasksCollection() {
    return FirebaseFirestore.instance
        .collection(TaskModel.collectionName)
        .withConverter<TaskModel>(
      fromFirestore: (snapshot, _) {
        return TaskModel.fromJson(snapshot.data()!);
      },
      toFirestore: (task, _) {
        return task.toJson();
      },
    );
  }

  static Future<void> addUser(UserModel user) {
    var collection = getUserCollection();
    var docRef = collection.doc(user.id);
    return docRef.set(user);
  }

  static Future<void> addTask(TaskModel model) {
    var collection = getTasksCollection();
    var docRef = collection.doc();

    model.id = docRef.id;
    return docRef.set(model);
  }

  static Stream<QuerySnapshot<TaskModel>> getTasks(DateTime date) {
    return getTasksCollection()
        .where("useId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where("date",
            isEqualTo: DateUtils.dateOnly(date).millisecondsSinceEpoch)
        .orderBy("title", descending: true)
        .snapshots();
  }

  static Future<void> deleteTask(String id) {
    return getTasksCollection().doc(id).delete();
  }

  static Future<UserModel?> readUser() async {
    String id = FirebaseAuth.instance.currentUser!.uid;
    DocumentSnapshot<UserModel> documentSnapshot =
        await getUserCollection().doc(id).get();
    return documentSnapshot.data();
  }

  static Future<void> updateTask(TaskModel model) {
    return getTasksCollection().doc(model.id).update(model.toJson());
  }

  static void createUserAccount(
      {required String email,
      required String password,
      required String username,
      required String phone,
      required Function onSuccess,
      required Function onError}) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      credential.user!.sendEmailVerification();
      FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      UserModel user = UserModel(
          id: credential.user?.uid ?? "",
          email: email,
          username: username,
          phone: phone);
     await addUser(user);
     onSuccess();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        onError(e.message);
      } else if (e.code == 'email-already-in-use') {
        onError(e.message);
      }
    } catch (e) {
      onError("Something went wrong");
    }
  }

  static login(String email, String password, Function onSuccess,
      Function onError) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credential.user!.emailVerified) {
        onSuccess();
      }
    } on FirebaseAuthException catch (e) {
      onError(e.message);
    }
  }

  static void logOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
