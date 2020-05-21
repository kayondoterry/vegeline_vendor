//import 'package:flutter/material.dart';
//import 'package:vegeline_vendor/models/order_status.dart';
//
//class OrderStatusSegment extends StatefulWidget {
//  final Function onChange;
//  final OrderStatusSegmentController controller;
//
//  const OrderStatusSegment({Key key, this.onChange, this.controller})
//      : super(key: key);
//
//  @override
//  _OrderStatusSegmentState createState() => _OrderStatusSegmentState();
//}
//
//class _OrderStatusSegmentState extends State<OrderStatusSegment> {
//  final _textStyle = TextStyle(
//    fontSize: 18.0,
//    fontWeight: FontWeight.normal,
//  );
//
//  Function _onChange;
//  OrderStatusSegmentController _controller;
//  String _currentStatus = OrderStatus.PENDING;
//  String _previousStatus = OrderStatus.PENDING;
//
//  bool _isCurrentStatus(String status) => status == _currentStatus;
//
//  void _changeStatus(String status) {
//    setState(() {
//      _previousStatus = _currentStatus;
//      _currentStatus = status;
//    });
//  }
//
//  void _callOnChange() {
//    if (_onChange != null && _currentStatus != _previousStatus)
//      _onChange(_currentStatus);
//  }
//
//  @override
//  void initState() {
//    _onChange = widget.onChange;
//    _controller = widget.controller;
//    if (_controller != null) _controller.addListener(_changeStatus);
//    super.initState();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Padding(
//      padding: const EdgeInsets.symmetric(horizontal: 10.0),
//      child: Container(
//        decoration: BoxDecoration(
//          border: Border.all(
//            color: Colors.grey[700],
//          ),
//          borderRadius: BorderRadius.circular(5.0),
//        ),
//        child: Row(
//          children: <Widget>[
//            Expanded(
//              child: InkWell(
//                onTap: () {
//                  _changeStatus(OrderStatus.PENDING);
//                  _callOnChange();
//                },
//                child: Container(
//                  color: _isCurrentStatus(OrderStatus.PENDING)
//                      ? Colors.grey
//                      : Colors.transparent,
//                  padding: EdgeInsets.symmetric(vertical: 5.0),
//                  child: Text(
//                    'Pending',
//                    textAlign: TextAlign.center,
//                    style: _textStyle,
//                  ),
//                ),
//              ),
//            ),
//            Expanded(
//              child: InkWell(
//                onTap: () {
//                  _changeStatus(OrderStatus.ON_GOING);
//                  _callOnChange();
//                },
//                child: Container(
//                  color: _isCurrentStatus(OrderStatus.ON_GOING)
//                      ? Colors.grey
//                      : Colors.transparent,
//                  padding: EdgeInsets.symmetric(vertical: 5.0),
//                  child: Text(
//                    'Ongoing',
//                    textAlign: TextAlign.center,
//                    style: _textStyle,
//                  ),
//                ),
//              ),
//            ),
//            Expanded(
//              child: InkWell(
//                onTap: () {
//                  _changeStatus(OrderStatus.COMPLETED);
//                  _callOnChange();
//                },
//                child: Container(
//                  color: _isCurrentStatus(OrderStatus.COMPLETED)
//                      ? Colors.grey
//                      : Colors.transparent,
//                  padding: EdgeInsets.symmetric(vertical: 5.0),
//                  child: Text(
//                    'Completed',
//                    textAlign: TextAlign.center,
//                    style: _textStyle,
//                  ),
//                ),
//              ),
//            ),
//          ],
//        ),
//      ),
//    );
//  }
//}
//
//class OrderStatusSegmentController {
//  List<Function> _listeners = [];
//
//  void changeStatus(String newStatus) {
//    _listeners.forEach((listener) => listener(newStatus));
//  }
//
//  void addListener(Function listener) {
//    _listeners.add(listener);
//  }
//
//  void dispose() {
//    _listeners = null;
//  }
//}
