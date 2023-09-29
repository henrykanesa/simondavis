import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../utils/app_color.dart';
import '../../../widgets/custom_input.dart';
import '../controllers/add_todo_controller.dart';

class AddTodoView extends GetView<AddTodoController> {
  const AddTodoView({Key? key}) : super(key: key);

  get style => null;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Input Data Monitoring',
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
          preferredSize: const Size.fromHeight(1),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 1,
            color: AppColor.secondaryExtraSoft,
          ),
        ),
      ),
      body: GetBuilder<AddTodoController>(builder: (controller) {
        //getBuilder => menggunakan semua custom dari AddToDoController
        return ListView(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(20),
          children: [
            CustomInput(
              controller: controller.tanggalC,
              label: 'Tanggal Monitoring',
              hint: DateTime.now().toString(),
              //isDate: true,
              disabled: true,
            ),
            CustomInput(
              controller: controller.waktuCawal,
              label: 'Waktu kedatangan',
              hint: 'Jam kedatangan',
              isTime: true,
            ),
            TextField(
              controller: controller.waktuC,
              keyboardType: TextInputType.number,
              onChanged: (val) {
                DateTime now = DateTime.now();
                var date = DateFormat('yyyy-MM-dd').format(now);

                var dateTime =
                    DateTime.parse("$date ${controller.waktuCawal.text}");
                var finalTime = DateFormat('HH:mm')
                    .format(dateTime.add(Duration(minutes: int.parse(val))));
                // DateTime.parse(controller.timeC.text).add(
                //     Duration(minutes: int.parse(controller.addtimeC.text)));
                controller.waktuCakhir.text = finalTime.toString();
                print(finalTime.toString());
                controller.update();
              },
            ),

            // CustomInput(
            //   controller: controller.waktuC,
            //   keyboardType: CustomInput.,
            //   onEditingComplete: () {
            //     DateTime now = DateTime.now();
            //     var date = DateFormat('yyyy-MM-dd').format(now);
            //     var dateTime =
            //         DateTime.parse("$date ${controller.waktuCawal.text}");
            //     var finalTime = DateFormat('HH:mm').format(dateTime
            //         .add(Duration(minutes: int.parse(controller.waktuC.text))));
            //     // DateTime.parse(controller.timeC.text).add(
            //     //     Duration(minutes: int.parse(controller.addtimeC.text)));
            //     controller.waktuCakhir.text = finalTime.toString();
            //     print(finalTime.toString());
            //     controller.update();
            //   },
            // ),
            CustomInput(
              controller: controller.waktuCakhir,
              label: 'Waktu Kepulangan',
              hint: 'Waktu Akhir Kunjungan',
              disabled: true,
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
              hint: 'Keterangan tambahan',
            ),
            (controller.file != null)
                ? Image.file(controller.file!)
                : const SizedBox(),
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
                      controller.addTodo();
                    }
                  },
                  child: Text(
                    (controller.isLoading.isFalse)
                        ? 'Tambah Data Monitoring'
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
