import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../routes/app_pages.dart';

class RegisterController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isHidden = true.obs;

  // TextEditingController emailC =
  //     TextEditingController(text: "matrix.black82@gmail.com");
  // TextEditingController passwordC = TextEditingController(text: "12345678");

  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();

  SupabaseClient client = Supabase.instance.client;

  void SignUp() async {
    if (emailC.text.isNotEmpty && passwordC.text.isNotEmpty) {
      //eksekusi
      isLoading.value = true;
      GotrueSessionResponse res =
          await client.auth.signUp(emailC.text, passwordC.text);
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

        //Kalau mau ada fitur email verification
        // Get.defaultDialog(
        //     barrierDismissible: false, //biar bagian belakang tidak bisa diklik
        //     title: "Registrasi Berhasi",
        //     middleText: "Periksa dan lakukan email konfirmasi",
        //     actions: [
        //       OutlinedButton(
        //         onPressed: () {
        //           Get.back(); //nutup showdialog
        //           Get.back(); //kembali ke layer sebelumnya
        //         },
        //         child: Text("OK"),
        //       ),
        //     ]);
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
