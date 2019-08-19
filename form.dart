import 'package:flutter/material.dart';

import 'package:flutter_app/item.dart';

typedef OnDelete();

class ItemForm extends StatefulWidget {
  final Item item;
  final state = _ItemFormState();
  final OnDelete onDelete;

  ItemForm({this.item, this.onDelete});
  @override
  _ItemFormState createState() => state;

  bool isValid() => state.validate();
}

class _ItemFormState extends State<ItemForm> {
  final form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(0),
      child: Card(
          child: Form(
        key: form,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            AppBar(
              leading: Icon(Icons.card_giftcard),
              title: Text("Ønske"),
              centerTitle: true,
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.delete_forever),
                  onPressed: widget.onDelete,
                )
              ],
            ),
            Padding(
                padding: EdgeInsets.all(0),
                child: TextFormField(
                  initialValue: widget.item.wish,
                  onSaved: (val) => widget.item.wish = val,
                  validator: (val) => val.length > 0 ? null : "Skriv dit ønske",
                  decoration: InputDecoration(
                      labelText: "Dit ønske", hintText: "skriv dit ønske her"),
                )),
            Padding(
                padding: EdgeInsets.all(0),
                child: TextFormField(
                  initialValue: widget.item.price,
                  onSaved: (val) => widget.item.price = val,
                  validator: (val) =>
                      val.length > 0 ? null : "Skriv prisen på dit ønske",
                  decoration: InputDecoration(
                      labelText: "Pris",
                      hintText: "skriv prisen på dit ønske her"),
                )),
          ],
        ),
      )),
    );
  }

  bool validate() {
    var valid = form.currentState.validate();
    if (valid) form.currentState.save();
    return valid;
  }
}
