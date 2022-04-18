import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:udemy_supabase/app/routes/app_pages.dart';

class HomeController extends GetxController {
  SupabaseClient client = Supabase.instance.client;
}
