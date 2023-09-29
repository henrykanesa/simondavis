import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../../utils/app_color.dart';
import '../../../widgets/custom_input.dart';
import '../controllers/detail_todo_controller.dart';

class DetailTodoView extends GetView<DetailTodoController> {
  const DetailTodoView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detail Kegiatan Monitoring',
          style: TextStyle(
            color: AppColor.secondary,
            fontSize: 14,
          ),
        ),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: SvgPicture.asset('assets/icons/arrow-left.svg'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.toNamed(Routes.EDIT_TODO, arguments: controller.argsData);
            },
            child: Text('Edit'),
            style: TextButton.styleFrom(
              primary: AppColor.primary,
            ),
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 1,
            color: AppColor.secondaryExtraSoft,
          ),
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.all(20),
        children: [
          CustomInput(
            controller: controller.tanggalC,
            label: 'Tanggal Monitoring',
            hint: DateTime.now().toString(),
            // isDate: true,
            disabled: true,
          ),
          CustomInput(
            controller: controller.waktuCAwal,
            label: 'Waktu Kedatangan',
            hint: 'Waktu Datang',
            disabled: true,
          ),
          CustomInput(
            controller: controller.waktuCAkhir,
            label: 'Waktu Kepulangan',
            hint: 'Waktu Pulang',
            disabled: true,
          ),
          CustomInput(
            controller: controller.namaDudiC,
            label: 'Nama DUDI',
            hint: 'Nama Perusahaan',
            disabled: true,
          ),
          CustomInput(
            controller: controller.alamatDudiC,
            label: 'Alamat DUDI',
            hint: 'Alamat Perusahaan',
            disabled: true,
          ),
          CustomInput(
            controller: controller.jumlahSiswaC,
            label: 'Jumlah Siswa',
            hint: '5',
            isNumber: true,
            disabled: true,
          ),
          CustomInput(
            controller: controller.kegiatanC,
            label: 'Uraian Kegiatan Monitoring',
            hint: 'Uraian Kegiatan Monitoring',
            disabled: true,
          ),
          CustomInput(
            controller: controller.keteranganC,
            label: 'Keterangan',
            hint: 'Tambahan keterangan',
            disabled: true,
          ),
          Image.network(controller.image),
          const SizedBox(
            height: 16,
          ),
          ElevatedButton(
            onPressed: () {
              controller.deleteTodo();
            },
            child: Text(
              'Delete Data Monitoring',
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'poppins',
              ),
            ),
            style: ElevatedButton.styleFrom(
              primary: AppColor.warning,
              padding: EdgeInsets.symmetric(vertical: 18),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
