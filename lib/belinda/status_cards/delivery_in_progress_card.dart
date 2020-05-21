import 'package:flutter/material.dart';
import 'package:vegeline_vendor/models/order.dart';
import 'package:vegeline_vendor/models/order_status.dart';
import 'package:vegeline_vendor/models/order_status_detail.dart';
import 'package:vegeline_vendor/services/db_service.dart';
import 'package:vegeline_vendor/shared/alert_system.dart';
import 'package:vegeline_vendor/shared/constants.dart';

class DeliveryInProgressCard extends StatefulWidget {
  final Order order;
  final bool isCardEnabled;
  final OrderStatusDetail orderStatusDetail;

  const DeliveryInProgressCard(
      {Key key, this.order, this.isCardEnabled, this.orderStatusDetail})
      : super(key: key);

  @override
  _DeliveryInProgressCardState createState() => _DeliveryInProgressCardState();
}

class _DeliveryInProgressCardState extends State<DeliveryInProgressCard>
    with AlertSystemMixin {
  List<Widget> _buildExtraFields() {
    if (widget.orderStatusDetail.extraFields == null) return [];
    return widget.orderStatusDetail.extraFields.map((field) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Text('${(field["name"] as String).toUpperCase()}'),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    '${field["value"]}',
                    style: TextStyle(fontSize: 19.0),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
          ],
        ),
      );
    }).toList();
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
              'DELIVERY IN PROGRESS',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[200]),
            ),
          ),
          widget.isCardEnabled
              ? Padding(
                  padding: const EdgeInsets.only(
                      left: 16.0, right: 16.0, bottom: 16.0, top: 16.0),
                  child: Text(
                    '$MESSAGE_DELIVERY_IN_PROGRESS',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ))
              : Container(height: 0, width: 0),
          widget.isCardEnabled
              ? Padding(
                  padding: const EdgeInsets.only(
                      left: 16.0, right: 16.0, bottom: 16.0, top: 16.0),
                  child: Column(
                    children: _buildExtraFields(),
                  ),
                )
              : Container(height: 0, width: 0),
        ],
      ),
    );
  }
}
