import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:notesapp/constant/linkapi.dart';
import 'package:notesapp/model/notemodel.dart';

class CardNotes extends StatelessWidget {
  final void Function() ontap;
  final NoteModel noteModel;
  final void Function()? onDelete;

  const CardNotes({
    Key? key,
    required this.ontap,
    required this.onDelete, 
    required this.noteModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Card(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Image.network(
                  "$linkImageRoot/${noteModel.notesImage}",
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                flex: 2,
                child: ListTile(
                  title: Text("${noteModel.notesTitle}"),
                  subtitle: Text("${noteModel.notesTitle}"),
                  trailing: IconButton(
                    icon: const Icon(
                      LineAwesomeIcons.trash,
                    ),
                    onPressed: onDelete,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
