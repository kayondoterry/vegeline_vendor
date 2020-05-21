import 'package:flutter/material.dart';
import 'package:vegeline_vendor/models/order.dart';
import 'package:vegeline_vendor/models/order_status.dart';
import 'package:vegeline_vendor/models/order_status_detail.dart';
import 'package:vegeline_vendor/services/db_service.dart';
import 'package:vegeline_vendor/shared/alert_system.dart';
import 'package:vegeline_vendor/shared/constants.dart';

class WaitingForPaymentCard extends StatefulWidget {
  final Order order;
  final bool isCardEnabled;

  const WaitingForPaymentCard({Key key, this.order, this.isCardEnabled}) : super(key: key);

  @override
  _WaitingForPaymentCardState createState() => _WaitingForPaymentCardState();
}

class _WaitingForPaymentCardState extends State<WaitingForPaymentCard>
    with AlertSystemMixin {

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
              'ORDER ACCEPTED',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[200]),
            ),
          ),
          !widget.isCardEnabled
              ? Container(height: 0,width: 0):Padding(
            padding: const EdgeInsets.only(
                left: 16.0, right: 16.0, bottom: 16.0, top: 16.0),
            child: Text(
              '$MESSAGE_WAITING_FOR_PAYMENT',
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
