// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Supabase supabase = await Supabase.initialize(
    url: "https://mtprnkufnynseoxszjgh.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im10cHJua3Vmbnluc2VveHN6amdoIiwicm9sZSI6ImFub24iLCJpYXQiOjE2NTAwODYyNzgsImV4cCI6MTk2NTY2MjI3OH0.NrvJWl513euRkF8HpCvdxbDM27DR_iUcZuMoG9SuOzU",
  );
  print("==================");
  print(supabase.client.auth.session()?.toJson());

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Udemy Supabase",
      initialRoute:
          supabase.client.auth.currentUser == null ? Routes.LOGIN : Routes.HOME,
      getPages: AppPages.routes,
      // initialRoute: Routes.HOME,
      // initialRoute:
      //     supabase.client.auth.currentUser == null ? Routes.LOGIN : Routes.HOME,
    ),
  );
}

      // debugShowCheckedModeBanner: false,
      // title: "Application",
      // initialRoute: AppPages.INITIAL,
      // getPages: AppPages.routes,
