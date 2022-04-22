import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:udemy_supabase/app/controllers/auth_controller.dart';

import '../../../data/models/node_model.dart';
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
        child: FutureBuilder(
          future: controller.getAllNotes(),
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Obx(() => (controller.allNotes.length == 0)
                ? Center(
                    child: Text("Tidak Ada data Notes"),
                  )
                : ListView.builder(
                    itemCount: controller.allNotes.length,
                    itemBuilder: (context, index) {
                      Notes note = controller.allNotes[index];

                      return ListTile(
                          onTap: (() =>
                              Get.toNamed(Routes.EDIT_NOTE, arguments: note)),
                          leading: CircleAvatar(
                            child: Text("${note.id} "),
                          ),
                          title: Text("${note.desc}"),
                          subtitle: Text("${note.desc}"),
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              controller.deleteID.value = note.id;
                              controller.deleteNote();
                            },
                          ));
                    },
                  ));
          }),
        ),
      ),
    );
  }
}
