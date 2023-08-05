import 'package:flutter/material.dart';

class MyAlertDialog extends StatelessWidget {
  String title;
  String content;
  List<Widget> actions;

  MyAlertDialog({this.title="",this.content="",this.actions = const[]});

  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      title: Text(
        this.title,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      actions: this.actions,
      content: Text(
        this.content,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}
