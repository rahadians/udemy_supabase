import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:supabase/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EditNoteController extends GetxController {
  //TODO: Implement EditNoteController
  RxBool isLoading = false.obs;
  TextEditingController titleC = TextEditingController();
  TextEditingController descC = TextEditingController();

  SupabaseClient client = Supabase.instance.client;

  Future<bool> editNotes(int no_id) async {
    if (titleC.text.isNotEmpty && descC.text.isNotEmpty) {
      isLoading.value = true;
      await client.from("notes").update({
        "title": titleC.text,
        "desc": descC.text,
      }).match({"id": no_id}).execute();
      isLoading.value = false;
      return true;
    } else {
      return false;
    }
  }

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

}
