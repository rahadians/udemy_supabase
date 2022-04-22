import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:udemy_supabase/app/routes/app_pages.dart';
import '../../../data/models/node_model.dart';

import 'package:supabase/supabase.dart';

class HomeController extends GetxController {
  RxList<Notes> allNotes = List<Notes>.empty().obs;
  RxInt deleteID = 0.obs;
  SupabaseClient client = Supabase.instance.client;

  Future<void> getAllNotes() async {
    try {
      PostgrestResponse<dynamic> user = await client
          .from("users")
          .select("id")
          .match({"uid": client.auth.currentUser!.id}).execute();

      int noId = (user.data as List).first['id'];

      var note = await client.from("notes").select() //.execute();
          .match({"user_id": noId}).execute();

      List<Notes> dataNote = Notes.fromJsonList((note.data as List));

      allNotes.value = List.from(dataNote);

      allNotes.refresh();
      print("sat");
    } catch (err) {
      print(err);
    }

    // isLoading.value = false;
    Get.back();
  }

  Future<void> deleteNote() async {
    print("oke");
    try {
      await client
          .from("notes")
          .delete()
          .match({"id": deleteID.value}).execute();

      await getAllNotes();
      print(deleteID.value);
    } catch (err) {
      print(err);
    }
  }
}
