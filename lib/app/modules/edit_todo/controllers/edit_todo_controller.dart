import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud_firebase/app/modules/add_todo/views/camera_view.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../../../widgets/custom_toast.dart';

class EditTodoController extends GetxController {
  //TODO: Implement EditTodoController

  final count = 0.obs;
  final Map<String, dynamic> argsData = Get.arguments;

  RxBool isLoading = false.obs;
  RxBool isLoadingCreateTodo = false.obs;
  String image = "";
  File? file;

  TextEditingController tanggalC = TextEditingController();
  TextEditingController waktuC = TextEditingController();
  TextEditingController namaDudiC = TextEditingController();
  TextEditingController alamatDudiC = TextEditingController();
  TextEditingController jumlahSiswaC = TextEditingController();
  TextEditingController kegiatanC = TextEditingController();
  TextEditingController keteranganC = TextEditingController();
  TextEditingController fotoC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  @override
  void onInit() {
    super.onInit();

    tanggalC.text = argsData["tanggal"];
    waktuC.text = argsData["waktu"];
    namaDudiC.text = argsData["namadudi"];
    alamatDudiC.text = argsData["alamatdudi"];
    jumlahSiswaC.text = argsData["jumlahsiswa"];
    kegiatanC.text = argsData["kegiatan"];
    keteranganC.text = argsData["keterangan"];
    image = argsData["image"];
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    tanggalC.dispose();
    waktuC.dispose();
    namaDudiC.dispose();
    alamatDudiC.dispose();
    jumlahSiswaC.dispose();
    kegiatanC.dispose();
    keteranganC.dispose();
    fotoC.dispose();
  }

  void pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      file = File(result.files.single.path ?? '');
    } else {
      // User canceled the picker
    }
    update();
  }

  void toCamera() {
    Get.to(CameraView())!.then((result) {
      file = result;
      update();
    });
  }

  Future<void> editTodo() async {
    if (tanggalC.text.isNotEmpty &&
        waktuC.text.isNotEmpty &&
        namaDudiC.text.isNotEmpty &&
        alamatDudiC.text.isNotEmpty &&
        jumlahSiswaC.text.isNotEmpty &&
        kegiatanC.text.isNotEmpty &&
        keteranganC.text.isNotEmpty) {
      isLoading.value = true;

      if (isLoadingCreateTodo.isFalse) {
        await editTodoData();
        isLoading.value = false;
      }
    } else {
      isLoading.value = false;
      CustomToast.errorToast('Error', 'you need to fill all form');
    }
  }

  editTodoData() async {
    isLoadingCreateTodo.value = true;
    String adminEmail = auth.currentUser!.email!;

    try {
      String uid = auth.currentUser!.uid;
      CollectionReference<Map<String, dynamic>> childrenCollection =
          await firestore.collection("users").doc(uid).collection("todos");

      DocumentReference todo = await firestore
          .collection("users")
          .doc(uid)
          .collection("todos")
          .doc(argsData["id"]);
      if (file != null) {
        String fileName = file!.path.split('/').last;
        String ext = fileName.split(".").last;
        String upDir = "image/${argsData["id"]}.$ext";

        var snapshot =
            await firebaseStorage.ref().child('images/$upDir').putFile(file!);
        var downloadUrl = await snapshot.ref.getDownloadURL();

        await childrenCollection.doc(argsData["id"]).update({
          "tanggal": tanggalC.text,
          "waktu": waktuC.text,
          "namadudi": namaDudiC.text,
          "alamatdudi": alamatDudiC.text,
          "jumlahsiswa": jumlahSiswaC.text,
          "kegiatan": kegiatanC.text,
          "keterangan": keteranganC.text,
          "image": downloadUrl,
          "created_at": DateTime.now().toIso8601String(),
        });
      } else {
        await childrenCollection.doc(argsData["id"]).update({
          "tanggal": tanggalC.text,
          "waktu": waktuC.text,
          "namadudi": namaDudiC.text,
          "alamatdudi": alamatDudiC.text,
          "jumlahsiswa": jumlahSiswaC.text,
          "kegiatan": kegiatanC.text,
          "keterangan": keteranganC.text,
          "created_at": DateTime.now().toIso8601String(),
        });
      }

      Get.back(); //close dialog
      Get.back(); //close form screen
      CustomToast.successToast(
          'Success', 'Berhasil memperbarui data monitoring');

      isLoadingCreateTodo.value = false;
    } on FirebaseAuthException catch (e) {
      isLoadingCreateTodo.value = false;
      CustomToast.errorToast('Error', 'error : ${e.code}');
    } catch (e) {
      isLoadingCreateTodo.value = false;
      CustomToast.errorToast('Error', 'error : ${e.toString()}');
    }
  }
}
