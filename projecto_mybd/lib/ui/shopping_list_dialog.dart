import 'package:flutter/material.dart';
import 'package:projecto_mybd/util/dbhelper.dart';
import 'package:projecto_mybd/models/shopping_list.dart';

class ShoppingListDialog{
  final txtName = TextEditingController();
  final txtPriority = TextEditingController();

  //isNew --> false --> edit
  //isNew --> true --> new
  Widget buildDialog(BuildContext context, ShoppingList list, bool isNew){
    DbHelper helper = DbHelper();
    if (!isNew){
      txtName.text = list.name;
      txtPriority.text = list.priority.toString();
    }

    return AlertDialog(
      title: Text((isNew)? 'New shopping list' : 'Edit shopping list'),
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
              controller: txtPriority,
              decoration: InputDecoration(
                  hintText: 'Priority (1-3)'
              ),
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(
                child: Text("Save"),
              onPressed: (){
                  list.name = txtName.text;
                  list.priority = int.parse(txtPriority.text);
                  helper.insertList(list);
                  Navigator.pop(context);
              },
                )
          ],
        ),
      ),
    );
  }
}