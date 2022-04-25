import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:notesapp/componets/crud.dart';
import 'package:notesapp/componets/customtextform.dart';
import 'package:notesapp/constant/linkapi.dart';
import 'package:notesapp/main.dart';

class AddNotes extends StatefulWidget {
  AddNotes({Key? key}) : super(key: key);

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> with Crud {
  File? file;
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  bool isLoading = false;
  addNotes() async {
    if (file == null) return AwesomeDialog(context: context, title: "Error").show();
    if (formstate.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      var response = await postRequestWithFile(
          linkAddNote,
          {
            "title": titleController.text,
            "content": contentController.text,
            "id": sharedPreferences.getString("id"),
          },
          file!);
      isLoading = false;
      setState(() {});
      if (response['status'] == "success") {
        Navigator.of(context).pushNamed("home");
      } else {}
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Notes"),
      ),
      body: isLoading == true
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              padding: const EdgeInsets.all(10),
              child: Form(
                key: formstate,
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    CustTextFormSign(
                      hint: "Title",
                      mycontroller: titleController,
                      valid: (value) {
                        if (value!.isEmpty) {
                          return "not Empty";
                        }
                        return null;
                      },
                    ),
                    CustTextFormSign(
                      minLine: 20,
                      maxline: 30,
                      hint: "Content",
                      mycontroller: contentController,
                      valid: (value) {
                        if (value!.isEmpty) {
                          return "not Empty";
                        }
                        return null;
                      },
                    ),
                    ElevatedButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => Container(
                            height: 150,
                            child: Column(
                              children: [
                                const Text(
                                  "Choose Image",
                                  style: TextStyle(fontSize: 20),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                InkWell(
                                  onTap: () async {
                                    XFile? xFile = await ImagePicker()
                                        .pickImage(source: ImageSource.gallery);
                                    file = File(xFile!.path);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    child: const Text(
                                      "Choose Image From Gallery",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () async {
                                    XFile? xFile = await ImagePicker()
                                        .pickImage(source: ImageSource.camera);
                                    file = File(xFile!.path);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    child: const Text(
                                      "Choose Image From  Camera",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      child: const Text("Choose Image"),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await addNotes();
                      },
                      child: const Text("Add Note"),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
