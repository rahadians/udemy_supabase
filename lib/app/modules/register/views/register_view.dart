import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Register'),
          centerTitle: true,
        ),
        body: ListView(
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
            TextFormField(
              autocorrect: false,
              controller: controller.passwordC,
              obscureText: controller.isHidden.value,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: controller.isHidden.isTrue
                        ? Icon(Icons.remove_red_eye)
                        : Icon(Icons.elderly_outlined),
                    onPressed: controller.isHidden.toggle(),
                  ),
                  label: Text("Password"),
                  border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {
                if (controller.isLoading.isFalse) {
                  //Eksekusi Login
                  controller.SignUp();
                }
              },
              child:
                  Text(controller.isLoading.isFalse ? "REGISTER" : "LOADING"),
            ),
          ],
        ));
  }
}
