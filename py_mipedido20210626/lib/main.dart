import 'package:flutter/material.dart';
import 'package:py_mipedido20210626/data/moor_database.dart';

void main() {
  runApp(Orders());
}

class Orders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Mi pedido!!"),
        ),
        body: SingleChildScrollView(
          child: NewOrder(),
        ),
      ),
    );
  }
}

class NewOrder extends StatefulWidget {
  @override
  _NewOrderState createState() => _NewOrderState();
}

class _NewOrderState extends State<NewOrder> {
  TextEditingController productNameController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          decoration: InputDecoration(hintText: "ingrese modelo"),
          keyboardType:  TextInputType.text,
          controller: productNameController,
        ),
        TextField(
          decoration: InputDecoration(hintText: "ingrese precio (S/.)"),
          keyboardType:  TextInputType.number,
          controller: priceController,
        ),
        RaisedButton(
          child: Text("Añadir"),
          onPressed: (){
            setState(() {
              AppDatabase().insertNewOrder(Order(
                product_name: productNameController.text,
                price: priceController.text,
              ));
              productNameController.clear();
              priceController.clear();
            });
          },
        ),
        Container(
          height: 700,
          width: double.infinity,
          child: StreamBuilder(
            stream: AppDatabase().watchAllorder(),
            builder: (context, AsyncSnapshot<List<Order>> snapshot) {
              return ListView.builder(
                itemBuilder: (_, index) {
                  return Card(
                    color: Colors.black12,
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text("${index + 1}"),
                        radius: 20,
                        backgroundColor: Colors.black54,
                      ),
                      title: Text(snapshot.data[index].product_name),
                      subtitle: Text("S/. ${snapshot.data[index].price}"),
                      trailing: IconButton(
                        icon: Icon(Icons.dangerous),
                        onPressed: (){
                          setState(() {
                            AppDatabase().deleteOrder(snapshot.data[index]);
                          });
                        },
                      ),
                    ),
                  );
                },
                itemCount: snapshot.data.length,
              );
            }
          ),
        )
      ],
    );
  }
}
