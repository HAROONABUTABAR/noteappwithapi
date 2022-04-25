import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:notesapp/app/notes/edit.dart';
import 'package:notesapp/componets/cardnote.dart';
import 'package:notesapp/componets/crud.dart';
import 'package:notesapp/constant/linkapi.dart';
import 'package:notesapp/main.dart';
import 'package:notesapp/model/notemodel.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with Crud {
  getNote() async {
    var response = await postRequest(linkViewNote, {
      "id": sharedPreferences.getString("id"),
    });
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        actions: [
          IconButton(
            icon: const Icon(LineAwesomeIcons.alternate_sign_out),
            onPressed: () {
              sharedPreferences.clear();
              Navigator.of(context)
                  .pushNamedAndRemoveUntil("login", (route) => false);
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("addnotes");
        },
        child: const Icon(Icons.add),
        backgroundColor: const Color(0xffFFCE00),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            FutureBuilder(
              future: getNote(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data['status'] == 'fail')
                    return Center(
                      child: Text("There is no notes"),
                    );
                  return ListView.builder(
                    itemCount: snapshot.data['data'].length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return CardNotes(
                        onDelete: () async {
                          var response = await postRequest(linkDeleteNote, {
                            "id": snapshot.data['data'][index]['notes_id']
                                .toString(),
                          });
                          if (response['status'] == "success") {
                            Navigator.of(context).pushReplacementNamed("home");
                          }
                        },
                        noteModel:
                            NoteModel.fromJson(snapshot.data['data'][index]),
                        ontap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => EditNotes(
                                notes: snapshot.data['data'][index],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: Text("Loading ..."),
                  );
                }
                return const Center(
                  child: Text("Loading ..."),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
