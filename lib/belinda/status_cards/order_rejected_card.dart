import 'package:flutter/material.dart';
import 'package:vegeline_vendor/models/order.dart';
import 'package:vegeline_vendor/models/order_status_detail.dart';
import 'package:vegeline_vendor/shared/constants.dart';

class OrderRejectedCard extends StatelessWidget {
  final Order order;
  final bool isCardEnabled;
  final OrderStatusDetail orderStatusDetail;

  const OrderRejectedCard(
      {Key key, this.order, this.isCardEnabled, this.orderStatusDetail})
      : super(key: key);

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
              'ORDER REJECTED',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[200]),
            ),
          ),
          !isCardEnabled ? Container(height: 0,width: 0) : Padding(
            padding: const EdgeInsets.only(
                left: 16.0, right: 16.0, bottom: 8.0, top: 16.0),
            child: Text(
              '$MESSAGE_REJECTED',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text('REASON FOR REJECTION'),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        '${orderStatusDetail.dataField}',
                        style: TextStyle(fontSize: 19.0),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
