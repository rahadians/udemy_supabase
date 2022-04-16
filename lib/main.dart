import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Supabase supabase = await Supabase.initialize(
    url: "https://wkoasaftlsumpzucgsav.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Indrb2FzYWZ0bHN1bXB6dWNnc2F2Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2NDU0NTk4MTYsImV4cCI6MTk2MTAzNTgxNn0.5qy5UepexXtqXD-suEWk5rhPmVWO-5B-SUejnkTkGY0",
  );

  print("=====================");
  print(supabase.client.auth.session()?.toJson());

  runApp(
    GetMaterialApp(
      title: "Supanote",
      initialRoute: supabase.client.auth.currentUser == null ? Routes.LOGIN : Routes.HOME,
      getPages: AppPages.routes,
    ),
  );
}
