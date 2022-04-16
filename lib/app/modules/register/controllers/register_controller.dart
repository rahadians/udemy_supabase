import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supanote/app/routes/app_pages.dart';

class RegisterController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isHidden = true.obs;
  TextEditingController emailC = TextEditingController(text: "kuldii.project@gmail.com");
  TextEditingController passC = TextEditingController(text: "password");

  SupabaseClient client = Supabase.instance.client;

  void signup() async {
    if (emailC.text.isNotEmpty && passC.text.isNotEmpty) {
      isLoading.value = true;
      GotrueSessionResponse res = await client.auth.signUp(emailC.text, passC.text);
      isLoading.value = false;

      if (res.error == null) {
        // tidak ada error -> berhasil signup
        print("------");
        print(res.data?.toJson());
        print(res.provider);
        print(res.url);
        print(res.user?.toJson());
        print(res.rawData);

        // tanpa fitur email verification
        Get.offAllNamed(Routes.HOME);

        // kalau mau ada fitur email verification
        // Get.defaultDialog(
        //   barrierDismissible: false,
        //   title: "BERHASIL REGISTER",
        //   middleText: "Periksa dan lakukan email konfirmasi. Kami telah mengirimkan email verifikasi ke email yang dimasukan.",
        //   actions: [
        //     OutlinedButton(
        //       onPressed: () {
        //         Get.back(); // tutup Dialog
        //         Get.back(); // kembali ke login
        //       },
        //       child: Text("OKAY SAYA MENGERTI"),
        //     ),
        //   ],
        // );
      } else {
        Get.snackbar("Terjadi Kesalahan", res.error!.message);
      }
    } else {
      Get.snackbar("Terjadi Kesalahan", "Email dan password belum diisi.");
    }
  }
}
