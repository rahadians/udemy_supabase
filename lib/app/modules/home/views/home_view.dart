import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:udemy_supabase/app/controllers/auth_controller.dart';

import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () => Get.toNamed(Routes.ADD_NOTE),
          child: Icon(Icons.add)),
      appBar: AppBar(
        title: Text('HOME'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () => Get.toNamed(Routes.PROFILE),
              icon: Icon(Icons.person))
        ],
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: 100,
          itemBuilder: (context, index) => ListTile(
            onTap: (() => Get.toNamed(Routes.EDIT_NOTE)),
            leading: CircleAvatar(
              child: Text("Judul ${index}"),
            ),
          ),
        ),
      ),
    );
  }
}
