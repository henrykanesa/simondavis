import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../../../utils/app_color.dart';
import '../../../widgets/custom_input.dart';
import '../controllers/edit_todo_controller.dart';

class EditTodoView extends GetView<EditTodoController> {
  const EditTodoView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Data Monitoring',
          style: TextStyle(
            color: AppColor.secondary,
            fontSize: 14,
          ),
        ),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: SvgPicture.asset('assets/icons/arrow-left.svg'),
        ),
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
      body: GetBuilder<EditTodoController>(builder: (controller) {
        return ListView(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.all(20),
          children: [
            CustomInput(
              controller: controller.tanggalC,
              label: 'Tanggal Monitoring',
              hint: DateTime.now().toString(),
              //isDate: true,
              disabled: true,
            ),
            CustomInput(
              controller: controller.waktuC,
              label: 'Lama Waktu Kunjungan',
              hint: '10',
              isNumber: true,
            ),
            CustomInput(
              controller: controller.namaDudiC,
              label: 'Nama DUDI',
              hint: 'Nama Perusahaan',
            ),
            CustomInput(
              controller: controller.alamatDudiC,
              label: 'Alamat DUDI',
              hint: 'Alamat Perusahaan',
            ),
            CustomInput(
              controller: controller.jumlahSiswaC,
              label: 'Jumlah Siswa',
              hint: '5',
              isNumber: true,
            ),
            CustomInput(
              controller: controller.kegiatanC,
              label: 'Uraian Kegiatan Monitoring',
              hint: 'Uraian Kegiatan Monitoring',
            ),
            CustomInput(
              controller: controller.keteranganC,
              label: 'Keterangan',
              hint: 'Keterangan',
            ),
            (controller.file != null)
                ? Image.file(controller.file!)
                : const SizedBox(),
            const SizedBox(
              height: 16,
            ),
            (controller.file == null)
                ? Image.network(
                    (controller.image != null)
                        ? controller.image
                        : 'https://placehold.co/600x400/png',
                  )
                : Image.file(controller.file!),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => controller.toCamera(),
                    child: Text(
                      'Kamera',
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'poppins',
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: AppColor.primary,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => controller.pickFile(),
                    child: Text(
                      'Galeri',
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'poppins',
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: AppColor.primary,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 32),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Obx(
                () => ElevatedButton(
                  onPressed: () {
                    if (controller.isLoading.isFalse) {
                      controller.editTodo();
                    }
                  },
                  child: Text(
                    (controller.isLoading.isFalse)
                        ? 'Edit Data Monitoring'
                        : 'Loading...',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'poppins',
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: AppColor.primary,
                    padding: EdgeInsets.symmetric(vertical: 18),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            )
          ],
        );
      }),
    );
  }
}
