import 'package:flutter/material.dart';
import 'package:vegeline_vendor/models/order.dart';
import 'package:vegeline_vendor/shared/constants.dart';

class OrderCanceledByCustomerCard extends StatelessWidget {
  final Order order;
  final bool isCardEnabled;

  const OrderCanceledByCustomerCard({Key key, this.order, this.isCardEnabled}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(8.0),
            color: Colors.grey[600],
            child: Text(
              'ORDER CANCELED',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[200]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              '$MESSAGE_CANCELLED_BY_CUSTOMER',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
