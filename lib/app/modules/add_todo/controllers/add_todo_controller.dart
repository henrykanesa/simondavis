// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'dart:io';
import '../../../widgets/custom_toast.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_crud_firebase/app/modules/add_todo/views/camera_view.dart';

class AddTodoController extends GetxController {
  //TODO: Implement AddTodoController

  final count = 0.obs;
  RxBool isLoading = false.obs;
  RxBool isLoadingCreateTodo = false.obs;

  TextEditingController tanggalC = TextEditingController();
  TextEditingController waktuCawal = TextEditingController();
  TextEditingController waktuC = TextEditingController();
  TextEditingController waktuCakhir = TextEditingController();
  TextEditingController namaDudiC = TextEditingController();
  TextEditingController alamatDudiC = TextEditingController();
  TextEditingController jumlahSiswaC = TextEditingController();
  TextEditingController kegiatanC = TextEditingController();
  TextEditingController keteranganC = TextEditingController();
  TextEditingController fotoC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  File? file;

  @override
  void onInit() {
    super.onInit();
    tanggalC.text = DateFormat('d-M-yyyy').format(DateTime.now());
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    tanggalC.dispose();
    waktuCawal.dispose();
    waktuC.dispose();
    waktuCakhir.dispose();
    namaDudiC.dispose();
    alamatDudiC.dispose();
    jumlahSiswaC.dispose();
    kegiatanC.dispose();
    keteranganC.dispose();
    fotoC.dispose();
  }

  void increment() => count.value++;

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

  Future<void> addTodo() async {
    if (tanggalC.text.isNotEmpty &&
        waktuCawal.text.isNotEmpty &&
        waktuC.text.isNotEmpty &&
        // waktuCakhir.text.isNotEmpty &&
        namaDudiC.text.isNotEmpty &&
        alamatDudiC.text.isNotEmpty &&
        jumlahSiswaC.text.isNotEmpty &&
        kegiatanC.text.isNotEmpty &&
        keteranganC.text.isNotEmpty &&
        file != null) {
      isLoading.value = true;
      createTodoData();
    } else {
      print("gagal");
    }
  }

  createTodoData() async {
    isLoadingCreateTodo.value = true;
    String adminEmail = auth.currentUser!.email!;
    if (file != null) {
      try {
        String uid = auth.currentUser!.uid;
        CollectionReference<Map<String, dynamic>> childrenCollection =
            // ignore: await_only_futures
            await firestore.collection("users").doc(uid).collection("todos");

        var uuidTodo = Uuid().v1();

        String fileName = file!.path.split('/').last;
        String ext = fileName.split(".").last;
        String upDir = "image/${uuidTodo}.$ext";

        var snapshot =
            await firebaseStorage.ref().child('images/$upDir').putFile(file!);
        var downloadUrl = await snapshot.ref.getDownloadURL();

        await childrenCollection.doc(uuidTodo).set({
          "task_id": uuidTodo,
          "tanggal": tanggalC.text,
          "waktuawal": waktuCawal.text,
          "waktu": waktuC.text,
          "waktuakhir": waktuCakhir.text,
          "namadudi": namaDudiC.text,
          "alamatdudi": alamatDudiC.text,
          "jumlahsiswa": jumlahSiswaC.text,
          "kegiatan": kegiatanC.text,
          "keterangan": keteranganC.text,
          "image": downloadUrl,
          "created_at": DateTime.now().toIso8601String(),
        });

        Get.back(); //close dialog
        Get.back(); //close form screen
        CustomToast.successToast('Success', 'Berhasil menambahkan todo');
      } on FirebaseAuthException catch (e) {
        isLoadingCreateTodo.value = false;
        CustomToast.errorToast('Error', 'error : ${e.code}');
      } catch (e) {
        isLoadingCreateTodo.value = false;
        CustomToast.errorToast('Error', 'error : ${e.toString()}');
      }
    } else {
      CustomToast.errorToast('Error', 'gambar tidak boleh kosong !!!');
    }
  }
}
