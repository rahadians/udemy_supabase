import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:supabase/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddNoteController extends GetxController {
  RxBool isLoading = false.obs;

  TextEditingController titleC = TextEditingController();
  TextEditingController descC = TextEditingController();

  SupabaseClient client = Supabase.instance.client;

  void addNote() async {
    if (titleC.text.isNotEmpty && descC.text.isNotEmpty) {
      isLoading.value = true;

      try {
        PostgrestResponse<dynamic> user = await client
            .from("users")
            .select("id")
            .match({"uid": client.auth.currentUser!.id}).execute();

        int no_id = (user.data as List).first['id'];

        await client.from("notes").insert({
          "user_id": no_id,
          "title": titleC.text,
          "desc": descC.text,
          "created_at": DateTime.now().toIso8601String()
        }).execute();
        print("udah kesimpen");
      } catch (err) {
        print(err);
      }

      isLoading.value = false;
      Get.back();
    }
  }

  // //TODO: Implement AddNoteController

  // final count = 0.obs;
  // @override
  // void onInit() {
  //   super.onInit();
  // }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  // @override
  // void onClose() {}
  // void increment() => count.value++;
}
