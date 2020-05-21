//import 'package:flutter/material.dart';
//import 'package:vegeline_vendor/belinda/completed_list_tile.dart';
//import 'package:vegeline_vendor/belinda/ongoing_list_tile.dart';
//import 'package:vegeline_vendor/belinda/pending_list_tile.dart';
//import 'package:vegeline_vendor/models/order.dart';
//import 'package:vegeline_vendor/models/order_status.dart';
//
//class OrderListForStatus extends StatefulWidget {
//  final String status;
//  final List<Order> orderList;
//
//  const OrderListForStatus({Key key, @required this.status, this.orderList})
//      : super(key: key);
//
//  @override
//  _OrderListForStatusState createState() => _OrderListForStatusState();
//}
//
//class _OrderListForStatusState extends State<OrderListForStatus>
//    with AutomaticKeepAliveClientMixin {
//  String _status;
//  List<Order> _orderList;
//
//  Widget _listTileForStatus(
//      {@required Order order, @required Function onPressed}) {
//    switch (_status) {
//      case OrderStatus.PENDING:
//        return PendingListTile(
//          order: order,
//          onPressed: onPressed,
//        );
//      case OrderStatus.ON_GOING:
//        return OnGoingListTile(
//          order: order,
//          onPressed: onPressed,
//        );
//      case OrderStatus.COMPLETED:
//        return CompletedListTile(
//          order: order,
//          onPressed: onPressed,
//        );
//      default:
//        return Center(child: Text('Unknown'));
//    }
//  }
//
//  @override
//  void initState() {
//    _status = widget.status;
//    _orderList = widget.orderList;
//    super.initState();
//  }
//
//  void _onOrderPressed(Order order) {}
//
//  @override
//  Widget build(BuildContext context) {
//    super.build(context);
//    return CustomScrollView(
//      slivers: <Widget>[
//        SliverList(
//          delegate: SliverChildBuilderDelegate(
//                (context, index) => ListTile(
//              title: Text('Order $_status $index'),
//            ),
//            childCount: 20,
////            (context, index) => _listTileForStatus(
////              order: _orderList[index],
////              onPressed: _onOrderPressed,
////            ),
////            childCount: _orderList.length,
//          ),
//        ),
//      ],
//    );
//  }
//
//  @override
//  bool get wantKeepAlive => true;
//}
