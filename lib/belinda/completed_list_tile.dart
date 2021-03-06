import 'package:flutter/material.dart';
import 'package:vegeline_vendor/models/order.dart';

class CompletedListTile extends StatelessWidget {

  final Order order;
  final Function onPressed;

  const CompletedListTile({Key key, this.order, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('${order.orderId}'),
      subtitle: Text('${order.quantity}'),
    );
  }
}
