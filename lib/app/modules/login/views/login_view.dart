import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:udemy_supabase/app/routes/app_pages.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Login'),
          centerTitle: true,
        ),
        body: SafeArea(
          child: ListView(
            padding: EdgeInsets.all(10),
            children: [
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
              Obx(() => TextFormField(
                    autocorrect: false,
                    controller: controller.passwordC,
                    obscureText: controller.isHidden.value,
                    textInputAction: TextInputAction.done,
                    // onChanged: (value)=>,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: controller.isHidden.isTrue
                              ? Icon(Icons.remove_red_eye)
                              : Icon(Icons.remove_red_eye_outlined),
                          onPressed: controller.isHidden.toggle(),
                        ),
                        label: Text("Password"),
                        border: OutlineInputBorder()),
                  )),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () {
                  if (controller.isLoading.isFalse) {
                    //Eksekusi Login
                    controller.login();
                  }
                },
                child: Obx(() =>
                    Text(controller.isLoading.isFalse ? "LOGIN" : "LOADING")),
              ),
              SizedBox(
                height: 20,
              ),
              TextButton(
                  onPressed: () => Get.toNamed(Routes.REGISTER),
                  child: Text("Register"))
            ],
          ),
        ));
  }
}
