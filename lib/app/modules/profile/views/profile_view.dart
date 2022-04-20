import 'package:flutter/material.dart';

import 'package:get/get.dart';

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
                            label: Text("Name"), border: OutlineInputBorder()),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        autocorrect: false,
                        readOnly: true,
                        controller: controller.emailC,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            label: Text("Email"), border: OutlineInputBorder()),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Obx(() => TextFormField(
                            autocorrect: false,
                            controller: controller.passwordC,
                            obscureText: controller.isHidden.value,
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  icon: controller.isHidden.isTrue
                                      ? Icon(Icons.remove_red_eye)
                                      : Icon(Icons.elderly_outlined),
                                  onPressed: () => controller.isHidden.toggle(),
                                ),
                                label: Text("New Password"),
                                border: OutlineInputBorder()),
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Last Login : ",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
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
                      Obx(() => ElevatedButton(
                            onPressed: () async {
                              if (controller.isLoading.isFalse) {
                                //Eksekusi UPDATE Profile

                                controller.updateProfile();

                                if (controller.passwordC.text.isNotEmpty &&
                                    controller.passwordC.text.length >= 6) {
                                  // controller.updateProfile();
                                  // await controller.logout();
                                  // await authC.reset();
                                  Get.toNamed(Routes.LOGIN);
                                }
                              }
                            },
                            child: Text(controller.isLoading.isFalse
                                ? "UPDATE PROFILE"
                                : "LOADING"),
                          )),
                    ],
                  ),
                ),
              );
            }));
  }
}
