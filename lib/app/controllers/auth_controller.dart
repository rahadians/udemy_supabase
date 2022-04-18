import 'dart:async';

import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:udemy_supabase/app/routes/app_pages.dart';

class AuthController extends GetxController {
  Timer? authTimer;

  SupabaseClient client = Supabase.instance.client;

  Future<void> autoLogout() async {
    if (authTimer != null) {
      authTimer!.cancel();
    }

    authTimer = Timer(Duration(seconds: 3600), () async {
      await client.auth.signOut();
      Get.offAllNamed(Routes.LOGIN);
    });

    print("Auto Logout Dijalankan");
  }

  Future<void> reset() async {
    if (authTimer != null) {
      authTimer!.cancel();
      authTimer = null;
    }
  }
}
