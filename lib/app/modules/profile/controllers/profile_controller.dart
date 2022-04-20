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

  Future<void> updateProfile() async {
    if (nameC.text.isNotEmpty) {
      isLoading.value = true;
      await client.from("users").update({
        "name": nameC.text,
      }).match({"uid": client.auth.currentUser!.id}).execute();

      if (passwordC.text.isNotEmpty) {
        print(client.auth.currentSession!.accessToken);
        if (passwordC.text.length > 6) {
          try {
            await client.auth.api.updateUser(
              // "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiJhdXRoZW50aWNhdGVkIiwiZXhwIjoxNjUwNDQ1NTQwLCJzdWIiOiIxYTVkZDMzNS02NjM2LTQ2NDgtYWRiNi04NTcyZDFkMjFkYjkiLCJlbWFpbCI6ImNAZ21haWwuY29tIiwicGhvbmUiOiIiLCJhcHBfbWV0YWRhdGEiOnsicHJvdmlkZXIiOiJlbWFpbCIsInByb3ZpZGVycyI6WyJlbWFpbCJdfSwidXNlcl9tZXRhZGF0YSI6e30sInJvbGUiOiJhdXRoZW50aWNhdGVkIn0.opEIcryULFvkGOokd3oe5jU0ff5Ez28VWsfWmES815g",
              // UserAttributes(password: "123456789")
              client.auth.currentSession!.accessToken.toString(),
              UserAttributes(password: passwordC.text.toString()),
            );
          } catch (e) {
            Get.snackbar("Terjadi Kesalahan", "errornya adalah ${e}");
          }
        } else {
          Get.snackbar("Terjadi Kesalahan", "Password harus 6 karakter");
        }
      }
    }
    isLoading.value = false;
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

  // @override
  // void onClose() {
  //   emailC.dispose();
  //   passwordC.dispose();
  // }
  // void increment() => count.value++;
}
