import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:udemy_supabase/app/routes/app_pages.dart';
import '../../../data/models/node_model.dart';

import 'package:supabase/supabase.dart';

class HomeController extends GetxController {
  RxList allNotes = List<Map<String, dynamic>>.empty().obs;

  SupabaseClient client = Supabase.instance.client;

  Future<void> getAllNotes() async {
    try {
      PostgrestResponse<dynamic> user = await client
          .from("users")
          .select("id")
          .match({"uid": client.auth.currentUser!.id}).execute();

      int no_id = (user.data as List).first['id'];

      var note = await client
          .from("notes")
          .select().execute();
          // .match({"user_id": no_id}).execute();

      List<Notes> dataNote = Notes.fromJsonList((note.data as List));

      allNotes.(dataNote);

      // allNotes.refresh();

      print("=======================");
      print(dataNote.length);
    } catch (err) {
      print("err");
    }

    // isLoading.value = false;
    Get.back();
  }
}
