import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../../../utils/app_color.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primary,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        elevation: 0.0,
        titleSpacing: 10.0,
        centerTitle: true,
        title: Text("SIMON PKL"),
        leading: IconButton(
          icon: SvgPicture.asset(
            'assets/icons/arrow-left.svg',
            color: Colors.white,
          ),
          onPressed: () => Get.back(),
        ),
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: ListView(
        shrinkWrap: true,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 20 / 100,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(left: 32),
            decoration: BoxDecoration(
              gradient: AppColor.primaryGradient,
              image: DecorationImage(
                image: AssetImage('assets/images/pattern-1-1.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "SiMOn PKL",
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontFamily: 'poppins',
                      height: 150 / 100,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Center(
                  child: Text(
                    "Sistem Monitoring Siswa Praktek Lapangan",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          Container(
            // height: MediaQuery.of(context).size.height * 70 / 100,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            padding: EdgeInsets.only(left: 20, right: 20, top: 36, bottom: 84),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Daftar',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'poppins',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(left: 14, right: 14, top: 4),
                  margin: EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        width: 1, color: AppColor.secondaryExtraSoft),
                  ),
                  child: TextField(
                    style: TextStyle(fontSize: 14, fontFamily: 'poppins'),
                    maxLines: 1,
                    controller: controller.nameC,
                    decoration: InputDecoration(
                      label: Text(
                        "Nama Lengkap",
                        style: TextStyle(
                          color: AppColor.secondarySoft,
                          fontSize: 14,
                        ),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: InputBorder.none,
                      hintText: "Isi Nama Lengkap Anda",
                      hintStyle: TextStyle(
                        fontSize: 14,
                        fontFamily: 'poppins',
                        fontWeight: FontWeight.w500,
                        color: AppColor.secondarySoft,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(left: 14, right: 14, top: 4),
                  margin: EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        width: 1, color: AppColor.secondaryExtraSoft),
                  ),
                  child: TextField(
                    style: TextStyle(fontSize: 14, fontFamily: 'poppins'),
                    maxLines: 1,
                    controller: controller.nipC,
                    decoration: InputDecoration(
                      label: Text(
                        "NIP",
                        style: TextStyle(
                          color: AppColor.secondarySoft,
                          fontSize: 14,
                        ),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: InputBorder.none,
                      hintText: "Isi NIP Anda",
                      hintStyle: TextStyle(
                        fontSize: 14,
                        fontFamily: 'poppins',
                        fontWeight: FontWeight.w500,
                        color: AppColor.secondarySoft,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(left: 14, right: 14, top: 4),
                  margin: EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        width: 1, color: AppColor.secondaryExtraSoft),
                  ),
                  child: Obx(
                    () => Column(
                      children: [
                        ListTile(
                          title: const Text('Guru Kejuruan'),
                          leading: Radio(
                            value: "Guru Kejuruan",
                            groupValue: controller.radio.value,
                            onChanged: (value) => controller.setRadio(value),
                          ),
                        ),
                        ListTile(
                          title: const Text('Guru Normada'),
                          leading: Radio(
                            value: "Guru Normada",
                            groupValue: controller.radio.value,
                            onChanged: (value) => controller.setRadio(value),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(left: 14, right: 14, top: 4),
                  margin: EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        width: 1, color: AppColor.secondaryExtraSoft),
                  ),
                  child: TextField(
                    style: TextStyle(fontSize: 14, fontFamily: 'poppins'),
                    maxLines: 1,
                    controller: controller.emailC,
                    decoration: InputDecoration(
                      label: Text(
                        "Email",
                        style: TextStyle(
                          color: AppColor.secondarySoft,
                          fontSize: 14,
                        ),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: InputBorder.none,
                      hintText: "Isi Nama Email Anda",
                      hintStyle: TextStyle(
                        fontSize: 14,
                        fontFamily: 'poppins',
                        fontWeight: FontWeight.w500,
                        color: AppColor.secondarySoft,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Material(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.only(left: 14, right: 14, top: 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                width: 1, color: AppColor.secondaryExtraSoft),
                          ),
                          child: Obx(
                            () => TextField(
                              style: TextStyle(
                                  fontSize: 14, fontFamily: 'poppins'),
                              maxLines: 1,
                              controller: controller.passC,
                              obscureText: controller.obsecureText.value,
                              decoration: InputDecoration(
                                label: Text(
                                  "Kata Sandi",
                                  style: TextStyle(
                                    color: AppColor.secondarySoft,
                                    fontSize: 14,
                                  ),
                                ),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                border: InputBorder.none,
                                hintText: "*************",
                                suffixIcon: IconButton(
                                  icon: (controller.obsecureText != false)
                                      ? SvgPicture.asset(
                                          'assets/icons/show.svg')
                                      : SvgPicture.asset(
                                          'assets/icons/hide.svg'),
                                  onPressed: () {
                                    controller.obsecureText.value =
                                        !(controller.obsecureText.value);
                                  },
                                ),
                                hintStyle: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'poppins',
                                  fontWeight: FontWeight.w500,
                                  color: AppColor.secondarySoft,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Text(
                        "Kata sandi minimal 6 karakter",
                        style: TextStyle(
                          color: AppColor.secondarySoft,
                          height: 150 / 100,
                        ),
                      ),
                    ],
                  ),
                ),
                Obx(
                  () => Container(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (controller.isLoading.isFalse) {
                          await controller.registration();
                        }
                      },
                      child: Text(
                        (controller.isLoading.isFalse)
                            ? 'Daftar'
                            : 'Loading...',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 18),
                        elevation: 0,
                        primary: AppColor.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
