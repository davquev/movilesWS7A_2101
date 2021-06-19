import 'package:flutter/material.dart';
import 'package:projecto_mybd/util/dbhelper.dart';
import 'package:projecto_mybd/models/shopping_list.dart';
import 'package:projecto_mybd/models/list_items.dart';
import 'package:projecto_mybd/ui/list_item_dialog.dart';

class ItemsScreen extends StatefulWidget {
  final ShoppingList shoppingList;
  ItemsScreen(this.shoppingList);

  @override
  _ItemsScreenState createState() => _ItemsScreenState(this.shoppingList);
}

class _ItemsScreenState extends State<ItemsScreen> {
  final ShoppingList shoppingList;
  _ItemsScreenState(this.shoppingList);

  DbHelper helper;
  List<ListItem> items;

  @override
  Widget build(BuildContext context) {
    LisItemtDialog dialog = LisItemtDialog();

    helper = DbHelper();
    showdata(this.shoppingList.id);
    return Scaffold(
      appBar: AppBar(
        title: Text(shoppingList.name),
      ),
      body: ListView.builder(
        itemCount: (items != null)? items.length : 0,
          itemBuilder: (BuildContext context, int index){
          return Dismissible(
          key: Key(items[index].name),
          onDismissed: (direction) {
            String srtName = items[index].name;
            helper.deleteItem(items[index]); //elimino de BD
            setState(() {
              items.removeAt(index); //elimino de la vista
            });
            Scaffold
                .of(context)
                .showSnackBar(SnackBar(content: Text("$srtName eliminado...")));
          },
            child: ListTile(
              title: Text(items[index].name),
              subtitle: Text(
                'Quantity: ${items[index].quantity} - Note: ${items[index].note}'
              ),
              trailing: IconButton(
                icon: Icon(Icons.edit),
                onPressed: (){
                  showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                          dialog.buildDialog(context, items[index], false));
                },
              )
            ),
          );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showDialog(
              context: context,
              builder: (BuildContext context) =>
                  dialog.buildDialog(context, ListItem(0, shoppingList.id, '', '', ''), true));
        },
        child: Icon(Icons.plus_one),
      ),
    );
  }

  Future showdata(int idList) async{
    await helper.openDb();
    items = await helper.getItems(idList);
    setState(() {
      items = items;
    });
  }
}
