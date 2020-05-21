//import 'package:flutter/material.dart';
//import 'package:flutter/cupertino.dart';
//import 'package:vegeline_vendor/belinda/order_list_for_status.dart';
//import 'package:vegeline_vendor/belinda/order_status_segment.dart';
//import 'package:vegeline_vendor/models/order.dart';
//import 'package:vegeline_vendor/models/order_status.dart';
//
//class OrderList extends StatefulWidget {
//  const OrderList({Key key}) : super(key: key);
//
//  @override
//  _OrderListState createState() => _OrderListState();
//}
//
//class _OrderListState extends State<OrderList>
//    with AutomaticKeepAliveClientMixin {
//  final _textStyle = const TextStyle(
//    fontWeight: FontWeight.normal,
//  );
//
//  List<Order> _orderList = [];
//
//  final _pages = [
//    OrderListForStatus(
//      status: OrderStatus.PENDING,
//      orderList: [],
//    ),
//    OrderListForStatus(
//      status: OrderStatus.ON_GOING,
//      orderList: [],
//    ),
//    OrderListForStatus(
//      status: OrderStatus.COMPLETED,
//      orderList: [],
//    ),
//  ];
//
//  PageController _pageController;
//  OrderStatusSegmentController _orderStatusSegmentController;
//
//  @override
//  void initState() {
//    _pageController = PageController();
//    _orderStatusSegmentController = OrderStatusSegmentController();
//    super.initState();
//  }
//
//  void _onPageChanged(int index) {
//    String _newStatus;
//    switch (index) {
//      case 0:
//        _newStatus = OrderStatus.PENDING;
//        break;
//      case 1:
//        _newStatus = OrderStatus.ON_GOING;
//        break;
//      case 2:
//        _newStatus = OrderStatus.COMPLETED;
//        break;
//    }
//    print('changing status to $_newStatus');
//    _orderStatusSegmentController.changeStatus(_newStatus);
//  }
//
//  void _onStatusChanged(String status) {
//    print('Status changed to $status');
//
//    switch (status) {
//      case OrderStatus.PENDING:
//        _pageController.jumpToPage(0);
//        break;
//      case OrderStatus.ON_GOING:
//        _pageController.jumpToPage(1);
//        break;
//      case OrderStatus.COMPLETED:
//        _pageController.jumpToPage(2);
//        break;
//    }
//  }
//
//  @override
//  void dispose() {
//    _pageController.dispose();
//    super.dispose();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    super.build(context);
//    return Scaffold(
//        body: NestedScrollView(
//      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
//        return [
//          SliverOverlapAbsorber(
//            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
//            child: SliverAppBar(
//              title: Column(
//                crossAxisAlignment: CrossAxisAlignment.stretch,
//                children: <Widget>[
//                  OrderStatusSegment(
//                    onChange: _onStatusChanged,
//                    controller: _orderStatusSegmentController,
//                  ),
//                ],
//              ),
//              backgroundColor: Colors.grey[100],
//              floating: true,
//              snap: true,
//              automaticallyImplyLeading: false,
//              forceElevated: innerBoxIsScrolled,
//            ),
//          ),
//        ];
//      },
//      body: PageView(
//        controller: _pageController,
//        children: _pages,
//        onPageChanged: _onPageChanged,
//      ),
//    ));
//  }
//
//  @override
//  bool get wantKeepAlive => true;
//}
