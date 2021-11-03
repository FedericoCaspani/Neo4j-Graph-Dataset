import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'DismissibleWidget.dart';

/*
* This class is for family
* */
class Contacts extends StatefulWidget {

  @override
  _ContactsState createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {

  // TODO: change it
  final items = List<String>.generate(20, (i) => "Item ${i + 1}");


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Contacts"),
      ),
      body: ListView.separated(
        itemCount: items.length,
        separatorBuilder: (context, index) => Divider(),
        itemBuilder: (context, index) {
          final item = items[index];
          return DismissibleWidget(
            item: item,
            child: buildListTile(item),
            onDismissed: (direction) => {
              dismissItem(context, index, direction)
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addItem,
        child: Icon(Icons.add),
      ),
    );
  }

  void _addItem() {
    setState(() {
       items.add("Item ${items.length}");
    });
  }

  // TODO: it's hardcoded
  // It should return users not strings!
  Widget buildListTile(String item) => ListTile(
    contentPadding: EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 16
    ),
    leading: CircleAvatar(
      radius: 28,
      backgroundImage: NetworkImage('https://via.placeholder.com/150'),
    ),
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          item,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4,),
        Text('blablabla'),
      ],
    ),
    onTap: () {},
  );

  void dismissItem(BuildContext context, int index, DismissDirection dismissDirection) {
    setState(() {
      items.removeAt(index);
    });

    switch(dismissDirection) {
      case DismissDirection.endToStart:
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Item $index deleted')));
        break;
      case DismissDirection.startToEnd:
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Item $index archived')));
        break;
      default:
        break;
    }
  }
}

