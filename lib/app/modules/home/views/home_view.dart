import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud_firebase/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_crud_firebase/app/routes/app_pages.dart';
import 'package:flutter_crud_firebase/app/utils/app_color.dart';
import 'package:get/get.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: controller.streamUser(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.active:
              case ConnectionState.done:
                Map<String, dynamic> user = snapshot.data!.data()!;
                return ListView(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 36),
                  children: [
                    SizedBox(height: 16),
                    // Section 1 - Welcome Back
                    Container(
                      margin: EdgeInsets.only(bottom: 16),
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              ClipOval(
                                child: Container(
                                  width: 42,
                                  height: 42,
                                  child: Image.network(
                                    (user["avatar"] == null ||
                                            user['avatar'] == "")
                                        ? "https://ui-avatars.com/api/?name=${user['name']}/"
                                        : user['avatar'],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(width: 24),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Selamat Datang Kembali",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: AppColor.secondarySoft,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    user["name"],
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'poppins',
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: () => {controller.logout()},
                            child: Text("Logout"),
                          ),
                        ],
                      ),
                    ),
                    // section 2 -  card
                    StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      stream: controller.streamTodo().asBroadcastStream(),
                      builder: (context, snapshot) {
                        // #TODO: make skeleton
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return Center(child: CircularProgressIndicator());
                          case ConnectionState.active:
                          case ConnectionState.done:
                            var todoLengthData = snapshot.data?.docs.length;
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.only(
                                  left: 24, top: 24, right: 24, bottom: 16),
                              decoration: BoxDecoration(
                                color: AppColor.primary,
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                  image:
                                      AssetImage('assets/images/pattern-1.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // job
                                  Text(
                                    user["email"],
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'poppins',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 16,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColor.primarySoft,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Container(
                                                margin:
                                                    EdgeInsets.only(bottom: 6),
                                                child: Text(
                                                  "Jumlah Kegiatan Monitoring",
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                "${todoLengthData.toString()}",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          default:
                            return SizedBox();
                        }
                      },
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Data Monitoring",
                            style: TextStyle(
                              fontFamily: "poppins",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextButton(
                            onPressed: () => Get.toNamed(Routes.ALL_TODO),
                            child: Text("Tampilkan Semua"),
                            style: TextButton.styleFrom(
                              primary: AppColor.primary,
                            ),
                          ),
                        ],
                      ),
                    ),

                    StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                        stream: controller.streamLastTodo().asBroadcastStream(),
                        builder: (context, snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                              return Center(child: CircularProgressIndicator());
                            case ConnectionState.active:
                            case ConnectionState.done:
                              List<QueryDocumentSnapshot<Map<String, dynamic>>>
                                  listResults = snapshot.data!.docs;
                              return ListView.separated(
                                itemCount: listResults.length,
                                shrinkWrap: true,
                                physics: BouncingScrollPhysics(),
                                separatorBuilder: (context, index) =>
                                    SizedBox(height: 16),
                                itemBuilder: (context, index) {
                                  var todoData = listResults[index].data();
                                  return InkWell(
                                    onTap: () => {
                                      Get.toNamed(
                                        Routes.DETAIL_TODO,
                                        arguments: {
                                          //yang didalam kurung kotak adalah nama kolom dalam database
                                          "id": "${todoData["task_id"]}",
                                          "tanggal": "${todoData["tanggal"]}",
                                          "waktuawal":
                                              "${todoData["waktuawal"]}",
                                          "waktu": "${todoData["waktu"]}",
                                          "waktuakhir":
                                              "${todoData["waktuakhir"]}",
                                          "namadudi": "${todoData["namadudi"]}",
                                          "alamatdudi":
                                              "${todoData["alamatdudi"]}",
                                          "jumlahsiswa":
                                              "${todoData["jumlahsiswa"]}",
                                          "kegiatan": "${todoData["kegiatan"]}",
                                          "keterangan":
                                              "${todoData["keterangan"]}",
                                          "image": "${todoData["image"]}",
                                        },
                                      ),
                                    },
                                    borderRadius: BorderRadius.circular(8),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          width: 1,
                                          color: AppColor.primaryExtraSoft,
                                        ),
                                      ),
                                      padding: EdgeInsets.only(
                                          left: 24,
                                          top: 20,
                                          right: 29,
                                          bottom: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Image.network(
                                                todoData["image"],
                                                width: 50,
                                              ),
                                              SizedBox(
                                                width: 20,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    (todoData["tanggal"] ==
                                                            null)
                                                        ? "-"
                                                        : "${todoData["tanggal"]}",
                                                    style:
                                                        TextStyle(fontSize: 12),
                                                  ),
                                                  Text(
                                                    "${todoData["namadudi"]}",
                                                    style:
                                                        TextStyle(fontSize: 12),
                                                  ),
                                                  Text(
                                                    "${todoData["kegiatan"]}",
                                                    style:
                                                        TextStyle(fontSize: 12),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            default:
                              return SizedBox();
                          }
                        }),
                    SizedBox(height: 64),
                  ],
                );
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              default:
                return Center(child: Text("Error"));
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(Routes.ADD_TODO);
        },
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}
