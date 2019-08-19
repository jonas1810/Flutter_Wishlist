import 'package:flutter/material.dart';
import 'package:flutter_app/emptystate.dart';
import 'package:flutter_app/form.dart';
import 'package:flutter_app/item.dart';

class MultiForm extends StatefulWidget {
  @override
  _MultiFormState createState() => _MultiFormState();
}

class _MultiFormState extends State<MultiForm> {
  List<ItemForm> items = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: .0,
        title: Text('Din ønskeListe'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.archive),
            onPressed: onSave,
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xffe4aaad),
              Color(0xffffffff),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: items.length <= 0
            ? Center(
                child: EmptyState(
                  title: 'ingen ønsker',
                  message: 'Tilføj et ønske ved at trykke på [+] knappen under',
                ),
              )
            : ListView.builder(
                addAutomaticKeepAlives: true,
                itemCount: items.length,
                itemBuilder: (_, i) => items[i],
              ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: onAddForm,
        foregroundColor: Colors.white,
        backgroundColor: Colors.redAccent,
      ),
    );
  }

  void onDelete(Item _item) {
    setState(() {
      var find = items.firstWhere(
        (it) => it.item == _item,
        orElse: () => null,
      );
      if (find != null) items.removeAt(items.indexOf(find));
    });
  }

  void onAddForm() {
    setState(() {
      var _items = Item();
      items.add(ItemForm(
        item: _items,
        onDelete: () => onDelete(_items),
      ));
    });
  }

  void onSave() {
    if (items.length > 0) {
      var allValid = true;
      items.forEach((form) => allValid = allValid && form.isValid());
      if (allValid) {
        var data = items.map((it) => it.item).toList();
        Navigator.push(
          context,
          MaterialPageRoute(
            fullscreenDialog: true,
            builder: (_) => Scaffold(
              appBar: AppBar(
                title: Text('Liste med ønsker'),
              ),
              body: ListView.builder(
                itemCount: data.length,
                itemBuilder: (_, i) => ListTile(
                  leading: Icon(
                    Icons.card_giftcard,
                  ),
                  title: Text(data[i].wish),
                  subtitle: Text(data[i].price),
                ),
              ),
            ),
          ),
        );
      }
    }
  }
}
