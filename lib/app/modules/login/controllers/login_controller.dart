import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../routes/app_pages.dart';

class LoginController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isHidden = true.obs;

  // TextEditingController emailC =
  //     TextEditingController(text: "matrix.black82@gmail.com");
  // TextEditingController passwordC = TextEditingController(text: "12345678");

  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();

  SupabaseClient client = Supabase.instance.client;

  void SignIn() async {
    if (emailC.text.isNotEmpty && passwordC.text.isNotEmpty) {
      //eksekusi
      isLoading.value = true;
      GotrueSessionResponse res = await client.auth
          .signIn(email: emailC.text, password: passwordC.text);
      isLoading.value = false;
      if (res.error == null) {
        //kalau null berarti berhasil
        print(res.data?.toJson());
        print(res.provider);
        print(res.url);
        print(res.user?.toJson());
        print(res.rawData);

        //kalu tidak ada email verification
        Get.offAllNamed(Routes.HOME);
      } else {
        Get.snackbar("Terjadi Kesalahan", res.error!.message);
      }
    } else {
      Get.snackbar("Terjadi Kesalahan", "Email dan Password belum diisi",
          duration: Duration(seconds: 2));
    }
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
  void onClose() {
    emailC.dispose();
    passwordC.dispose();
  }
  // void increment() => count.value++;
}
