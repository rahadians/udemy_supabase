import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isHidden = true.obs;

  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
}
