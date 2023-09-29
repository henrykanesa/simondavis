import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllTodoController extends GetxController {
  //TODO: Implement AllTodoController

  final count = 0.obs;
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  TextEditingController searchC = TextEditingController();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  Future<QuerySnapshot<Map<String, dynamic>>> getAllResult() async {
    String uid = auth.currentUser!.uid;
    QuerySnapshot<Map<String, dynamic>> query;
    if (searchC.text != "") {
      query = await firestore
          .collection("users")
          .doc(uid)
          .collection("todos")
          .where("namadudi", isGreaterThanOrEqualTo: searchC.text)
          .where("namadudi", isLessThan: "${searchC.text}z")
          // .orderBy(
          //   "created_at",
          //   descending: true,
          // )
          .get();
    } else {
      query = await firestore
          .collection("users")
          .doc(uid)
          .collection("todos")
          .orderBy(
            "created_at",
            descending: true,
          )
          .get();
    }
    return query;
  }
}
