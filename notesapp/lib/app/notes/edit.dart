import 'package:flutter/material.dart';
import 'package:notesapp/componets/crud.dart';
import 'package:notesapp/componets/customtextform.dart';
import 'package:notesapp/constant/linkapi.dart';

import '../../main.dart';

class EditNotes extends StatefulWidget {
  final notes;
  EditNotes({Key? key, this.notes}) : super(key: key);

  @override
  State<EditNotes> createState() => _EditNotesState();
}

class _EditNotesState extends State<EditNotes> with Crud {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  bool isLoading = false;
  editNotes() async {
    if (formstate.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      var response = await postRequest(
        linkEditNote,
        {
          "title": titleController.text,
          "content": contentController.text,
          "id": widget.notes["notes_id"].toString(),
        },
      );
      isLoading = false;
      setState(() {});
      if (response['status'] == "success") {
        Navigator.of(context).pushNamed("home");
      } else {}
    }
  }

  @override
  void initState() {
    titleController.text = widget.notes['notes_title'];
    contentController.text = widget.notes['notes_content'];

    super.initState();
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
                      onPressed: () async {
                        await editNotes();
                      },
                      child: const Text("Edit Note"),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
