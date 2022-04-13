// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:get/get.dart';

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
            padding: EdgeInsets.all(20),
            children: [
              TextField(
                controller: controller.emailC,
                autocorrect: false,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                    labelText: "Email", border: OutlineInputBorder()),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: controller.passwordC,
                obscureText: (controller.isHidden.value),
                autocorrect: false,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () => controller.isHidden.toggle(),
                    icon: controller.isHidden.isTrue
                        ? Icon(Icons.visibility_off)
                        : Icon(Icons.visibility),
                  ),
                  labelText: "Password",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Obx(
                () => ElevatedButton(
                  onPressed: () {
                    if (controller.isLoading.isFalse) {
                      //eksekusi Login

                    }
                  },
                  child:
                      Text(controller.isLoading.isFalse ? "Login" : "Loading"),
                ),
              ),
            ],
          ),
        ));
  }
}
