import 'package:flutter/material.dart';

class AlertSystemMixin {
  void alertMessageWithScaffoldState(ScaffoldState scaffoldState, String message) {

    final SnackBar snackBar = SnackBar(content: Row(
      children: <Widget>[
        Icon(Icons.info_outline),
        SizedBox(width: 10.0),
        Expanded(child: Text(message)),
      ],
    ));
    scaffoldState.showSnackBar(snackBar);
  }

  void alertMessageWithContext(BuildContext context, String message) {

    final SnackBar snackBar = SnackBar(content: Row(
      children: <Widget>[
        Icon(Icons.info_outline),
        SizedBox(width: 10.0),
        Expanded(child: Text(message)),
      ],
    ));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void alertErrorWithScaffoldState(ScaffoldState scaffoldState, String message) {

    final SnackBar snackBar = SnackBar(content: Row(
      children: <Widget>[
        Icon(Icons.error_outline),
        SizedBox(width: 10.0),
        Expanded(child: Text(message)),
      ],
    ));
    scaffoldState.showSnackBar(snackBar);
  }

  void alertErrorWithContext(BuildContext context, String message) {

    final SnackBar snackBar = SnackBar(content: Row(
      children: <Widget>[
        Icon(Icons.error_outline),
        SizedBox(width: 10.0),
        Expanded(child: Text(message)),
      ],
    ));
    Scaffold.of(context).showSnackBar(snackBar);
  }
}