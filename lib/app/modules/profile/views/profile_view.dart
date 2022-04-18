import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get/get_connect/sockets/src/sockets_html.dart';
import '../../../routes/app_pages.dart';
import '../../../controllers/auth_controller.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  final authC = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('MY PROFILE'),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () async {
                await controller.logout();
                await authC.reset();
                Get.toNamed(Routes.LOGIN);
              },
              icon: Icon(Icons.logout_outlined),
            ),
          ],
        ),
        body: FutureBuilder(
            future: controller.getProfile(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ListView(
                    children: [
                      TextFormField(
                        autocorrect: false,
                        controller: controller.nameC,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            label: Text("Home"), border: OutlineInputBorder()),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        autocorrect: false,
                        controller: controller.emailC,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            label: Text("Email"), border: OutlineInputBorder()),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Last Login : ",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Obx(
                        () => Text(
                          "${controller.lastLogin}",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (controller.isLoading.isFalse) {
                            //Eksekusi UPDATE Profile

                          }
                        },
                        child: Text(controller.isLoading.isFalse
                            ? "UPDATE PROFILE"
                            : "LOADING"),
                      ),
                    ],
                  ),
                ),
              );
            }));
  }
}
