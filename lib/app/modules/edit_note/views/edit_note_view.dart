import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../home/controllers/home_controller.dart';
import '../controllers/edit_note_controller.dart';
import '../../../data/models/node_model.dart';

class EditNoteView extends GetView<EditNoteController> {
  final homeC = Get.find<HomeController>();

  Notes note = Get.arguments; //mengambil data dari model data

  @override
  Widget build(BuildContext context) {
    controller.titleC.text = note.title;
    controller.descC.text = note.desc;
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Notes'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(20),
          children: [
            TextFormField(
              controller: controller.titleC,
              autocorrect: false,
              decoration: InputDecoration(
                  labelText: "Title", border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: controller.descC,
              autocorrect: false,
              decoration: InputDecoration(
                  labelText: "Description", border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 20,
            ),
            Obx(
              () => ElevatedButton(
                onPressed: () async {
                  if (controller.isLoading.isFalse) {
                    //eksekusi edit note

                    bool res = await controller.editNotes(note.id);
                    if (res == true) {
                      await homeC.getAllNotes();
                      Get.back();
                    }
                    // controller.addNote();
                    // homeC.getAllNotes();
                  }
                },
                child: Text(
                    controller.isLoading.isFalse ? "EDIT NOTES" : "LOADING.."),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
