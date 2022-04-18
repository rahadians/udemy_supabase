import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:intl/intl.dart';
import '../../../routes/app_pages.dart';

class ProfileController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isHidden = true.obs;
  RxString lastLogin = "-".obs;

  // TextEditingController emailC =
  //     TextEditingController(text: "matrix.black82@gmail.com");
  // TextEditingController passwordC = TextEditingController(text: "12345678");

  TextEditingController nameC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();

  SupabaseClient client = Supabase.instance.client;

  Future<void> getProfile() async {
    PostgrestResponse<dynamic> response = await client
        .from("users")
        .select()
        .match({"uid": client.auth.currentUser!.id}).execute();

    Map<String, dynamic> user =
        (response.data as List).first as Map<String, dynamic>;

    nameC.text = user["name"];
    emailC.text = user["email"];

    lastLogin.value = DateFormat('dd-MM-yyy hh:mm:ss')
        .format(DateTime.parse(client.auth.currentUser!.lastSignInAt!));

    // print(response.toJson());
  }

  Future<void> logout() async {
    await client.auth.signOut();
  }

  @override
  void onInit() {
    emailC = TextEditingController();
    passwordC = TextEditingController();
    super.onInit();
  }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  @override
  void onClose() {
    emailC.dispose();
    passwordC.dispose();
  }
  // void increment() => count.value++;
}
