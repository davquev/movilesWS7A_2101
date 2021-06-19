import 'package:flutter/material.dart';
import 'package:projecto_mybd/util/dbhelper.dart';
import 'package:projecto_mybd/models/list_items.dart';

class LisItemtDialog{
  final txtName = TextEditingController();
  final txtQuantity = TextEditingController();
  final txtNote = TextEditingController();

  //isNew --> false --> edit
  //isNew --> true --> new
  Widget buildDialog(BuildContext context, ListItem item, bool isNew){
    DbHelper helper = DbHelper();
    if (!isNew){
      txtName.text = item.name;
      txtQuantity.text = item.quantity;
      txtNote.text = item.note;
    }
    else{
      txtName.text = "";
      txtQuantity.text = "";
      txtNote.text = "";
    }

    return AlertDialog(
      title: Text((isNew)? 'New item' : 'Edit item'),
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TextField(
              controller: txtName,
              decoration: InputDecoration(
                  hintText: 'Name'
              ),
            ),
            TextField(
              controller: txtQuantity,
              decoration: InputDecoration(
                  hintText: 'Quantity'
              ),
            ),
            TextField(
              controller: txtNote,
              decoration: InputDecoration(
                  hintText: 'Note'
              ),
            ),
            ElevatedButton(
              child: Text("Save item"),
              onPressed: (){
                item.name = txtName.text;
                item.quantity = txtQuantity.text;
                item.note = txtNote.text;
                helper.insertItem(item);
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}