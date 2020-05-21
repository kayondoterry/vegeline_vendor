import 'dart:async';
import "dart:convert" as convert;

import 'package:flutter/material.dart';
import 'package:vegeline_vendor/models/order.dart';
import 'package:vegeline_vendor/models/order_status.dart';
import 'package:vegeline_vendor/models/order_status_detail.dart';
import 'package:vegeline_vendor/services/db_service.dart';
import 'package:vegeline_vendor/shared/constants.dart';

class VendorPaymentInProgressCard extends StatefulWidget {
  final Order order;
  final bool isCardEnabled;
  final OrderStatusDetail orderStatusDetail;

  const VendorPaymentInProgressCard(
      {Key key, this.order, this.isCardEnabled, this.orderStatusDetail})
      : super(key: key);

  @override
  _VendorPaymentInProgressCardState createState() =>
      _VendorPaymentInProgressCardState();
}

class _VendorPaymentInProgressCardState
    extends State<VendorPaymentInProgressCard> {
  DBService _db = DBService();

  @override
  void initState() {
    Timer(Duration(seconds: 2), () async {
      OrderStatusDetail statusDetail = OrderStatusDetail(
        status: OrderStatus.VENDOR_PAYMENT_SUCCESSFUL,
      );
      await _db.updateOrderStatus(widget.order, statusDetail);
    });
    super.initState();
  }

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
              'PAYMENT IN PROGRESS',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[200]),
            ),
          ),
          !widget.isCardEnabled
              ? Container(height: 0, width: 0)
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    '$MESSAGE_VENDOR_PAYMENT_IN_PROGRESS',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ),
          !widget.isCardEnabled
              ? Container(height: 0, width: 0)
              : Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Text('Phone Number'),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              '${widget.orderStatusDetail.dataField}',
                              style: TextStyle(fontSize: 19.0),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.0),
                    ],
                  ),
                )
        ],
      ),
    );
  }
}
