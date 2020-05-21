import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:vegeline_vendor/models/order.dart';
import 'package:vegeline_vendor/models/order_status.dart';
import 'package:vegeline_vendor/models/vendor.dart';
import 'package:vegeline_vendor/services/db_service.dart';
import 'package:vegeline_vendor/shared/constants.dart';

class OrdersPage extends StatefulWidget {
  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage>
    with AutomaticKeepAliveClientMixin {
  DBService _db = DBService();
  Stream<List<Order>> _orderStream;

  @override
  void initState() {
    final vendor = Provider.of<Vendor>(context, listen: false);
    _orderStream = _db.orderStreamForVendor(vendor.vendorId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: appBarTitle,
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.grey[100],
      ),
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                child: SliverAppBar(
                  title: Text(
                    'My Orders',
                    style: TextStyle(
                      fontSize: 36.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  backgroundColor: Colors.grey[100],
                  floating: true,
                  snap: true,
                  forceElevated: innerBoxIsScrolled,
                  actions: <Widget>[
                    IconButton(
                      onPressed: () async {},
                      icon: Icon(Icons.filter_list),
                      iconSize: 36.0,
                    ),
                  ],
                ),
              ),
            ];
          },
          body: StreamBuilder<List<Order>>(
            stream: _orderStream,
            builder: (context, snapshot) {
              if (snapshot.hasError)
                return Center(
                    child: Text('Error\n${snapshot.error.toString()}'));
              if (snapshot.connectionState == ConnectionState.waiting)
                return Center(child: Text('Loading'));
              List<Order> _orderList = snapshot.data..sort((order1, order2) {
                return order2.orderDate.compareTo(order1.orderDate);
              });
              if (_orderList.isEmpty) return Center(child: Text('No orders'));
              return CustomScrollView(
                slivers: [
                  SliverOverlapInjector(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                        context),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final int itemIndex = index ~/ 2;
                        if (index.isEven) {
                          Order _order = _orderList[itemIndex];
                          return OrderListItem(
                            order: _order,
                            onPressed: () {
                              Navigator.pushNamed(context, '/orderDetail',
                                  arguments: _order.orderId);
                            },
                          );
                        }
                        return Divider();

//                        return ListTile(
//                          onTap: () {
//                            Navigator.pushNamed(context, '/orderDetail',
//                                arguments: _order.orderId);
//                          },
//                          title: Text(
//                              '${_order.vendorProduct.product.productName} - ${_order.orderDate.timeZoneName}'),
//                          subtitle: Text('${_order.currentStatusDetail.status}'),
//                        );
                      },
                      semanticIndexCallback: (Widget widget, int localIndex) {
                        if (localIndex.isEven) {
                          return localIndex ~/ 2;
                        }
                        return null;
                      },
                      childCount: math.max(0, _orderList.length * 2 - 1),
                    ),
                  ),
                ],
              );
            },
          )),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class OrderListItem extends StatelessWidget {
  final Order order;
  final Function onPressed;

  const OrderListItem({Key key, @required this.order, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPressed,
      title: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              '${order.vendorProduct.product.productName}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Text(
            '${order.quantity * order.vendorProduct.price}',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
      subtitle: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  'Quantity: ${order.quantity}',
                ),
              ),
              Text(
                DateTime.now().difference(order.orderDate).inDays < 1
                    ? 'Today'
                    : '${DateFormat.yMEd().format(order.orderDate)}',
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  'Status: ${OrderStatus.getUserFriendlyStatus(order.status)}',
                ),
              ),
              Text(
                '${order.orderDate.hour}:${order.orderDate.minute}',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
