import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/custom_alert_dialog.dart';
import '../../../widgets/custom_toast.dart';

class DetailTodoController extends GetxController {
  //TODO: Implement DetailTodoController

  final count = 0.obs;
  final Map<String, dynamic> argsData = Get.arguments;
  RxBool isLoading = false.obs;
  RxBool isLoadingCreateTodo = false.obs;

  TextEditingController tanggalC = TextEditingController();
  TextEditingController waktuCAwal = TextEditingController();
  TextEditingController waktuC = TextEditingController();
  TextEditingController waktuCAkhir = TextEditingController();
  TextEditingController namaDudiC = TextEditingController();
  TextEditingController alamatDudiC = TextEditingController();
  TextEditingController jumlahSiswaC = TextEditingController();
  TextEditingController kegiatanC = TextEditingController();
  TextEditingController keteranganC = TextEditingController();
  TextEditingController fotoC = TextEditingController();
  String image = "";
  String imageName = "";

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  @override
  void onInit() {
    super.onInit();
    tanggalC.text = argsData["tanggal"];
    waktuCAwal.text = argsData["waktuawal"];
    waktuC.text = argsData["waktu"];
    waktuCAkhir.text = argsData["waktuakhir"];
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
    waktuCAwal.dispose();
    waktuC.dispose();
    waktuCAkhir.dispose();
    namaDudiC.dispose();
    alamatDudiC.dispose();
    jumlahSiswaC.dispose();
    kegiatanC.dispose();
    keteranganC.dispose();
    fotoC.dispose();
  }

  void increment() => count.value++;

  Future<void> deleteTodo() async {
    CustomAlertDialog.showPresenceAlert(
      title: "Hapus data monitoring",
      message: "Apakah anda ingin menghapus data monitoring ini ?",
      onCancel: () => Get.back(),
      onConfirm: () async {
        Get.back(); // close modal
        Get.back(); // back page
        try {
          String uid = auth.currentUser!.uid;
          await firestore
              .collection('users')
              .doc(uid)
              .collection('todos')
              .doc(argsData['id'])
              .delete();
          await firebaseStorage.refFromURL(image).delete();
          CustomToast.successToast(
              'Success', 'Data Monitoring berhasil dihapus');
        } catch (e) {
          CustomToast.errorToast(
              "Error", "Error dikarenakan : ${e.toString()}");
        }
      },
    );
  }
}
