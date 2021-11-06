import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DismissibleWidget<T> extends StatelessWidget {
  final Widget child;
  final T item;
  final DismissDirectionCallback onDismissed;

  const DismissibleWidget({
    required this.child,
    required this.item,
    required this.onDismissed,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ObjectKey(item),
      child: child,
      background: buildSwipeActionLeft(),
      secondaryBackground: buildSwipeActionRight(),
      onDismissed: onDismissed,
    );
  }

  // TODO: implement archive
  Widget buildSwipeActionLeft() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: 20),
      color: Colors.green,
      child: Icon(Icons.archive_sharp, color: Colors.white, size: 32),
    );
  }

  Widget buildSwipeActionRight() {
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.symmetric(horizontal: 20),
      color: Colors.red,
      child: Icon(Icons.delete_forever, color: Colors.white, size: 32),
    );
  }
}