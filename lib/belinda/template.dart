// order list backup
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:vegeline_vendor/models/order.dart';

class OrderList extends StatefulWidget {
  const OrderList({Key key}) : super(key: key);

  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList>
    with AutomaticKeepAliveClientMixin {
  final _textStyle = const TextStyle(
    fontWeight: FontWeight.normal,
  );

  List<Order> _orderList = [];



  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.grey[50],
            elevation: 1.0,
            pinned: true,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                CupertinoSegmentedControl(
                  unselectedColor: Colors.white70,
                  selectedColor: Colors.black,
                  children: {
                    "Pending": Padding(
                      child: Text(
                        'Pending',
                        style: _textStyle,
                      ),
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                    ),
                    "Ongoing": Text(
                      'Ongoing',
                      style: _textStyle,
                    ),
                    "Completed": Text(
                      'Completed',
                      style: _textStyle,
                    ),
                  },
                  onValueChanged: (val) {},
                ),
              ],
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                return ListTile(
                  title: Text('Order $index'),
                );
              },
              childCount: 30,
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

