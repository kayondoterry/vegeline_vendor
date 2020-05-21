import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:vegeline_vendor/belinda/status_cards/order_canceled_by_vendor_card.dart';
import 'package:vegeline_vendor/belinda/status_cards/order_rejected_card.dart';
import 'package:vegeline_vendor/belinda/status_cards/vendor_payment_in_progress_card.dart';
import 'package:vegeline_vendor/belinda/status_cards/payment_successful_card.dart';
import 'package:vegeline_vendor/models/order.dart';
import 'package:vegeline_vendor/models/order_status.dart';
import 'package:vegeline_vendor/models/order_status_detail.dart';
import 'package:vegeline_vendor/belinda/status_cards/delivery_in_progress_card.dart';
import 'package:vegeline_vendor/belinda/status_cards/order_canceled_by_customer_card.dart';
import 'package:vegeline_vendor/belinda/status_cards/order_delivered_card.dart';
import 'package:vegeline_vendor/belinda/status_cards/pending_order_card.dart';
import 'package:vegeline_vendor/belinda/status_cards/waiting_for_delivery_card.dart';
import 'package:vegeline_vendor/belinda/status_cards/waiting_for_payment.dart';

class OrderDetail extends StatefulWidget {
  final Order order;

  const OrderDetail({Key key, this.order}) : super(key: key);

  @override
  _OrderDetailState createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  List<OrderStatusDetail> get _statusHistory => widget.order.statusHistory
      .where((statusDetail) => ![OrderStatus.CUSTOMER_PAYMENT_IN_PROGRESS]
          .contains(statusDetail.status))
      .toList();
  ScrollController _scrollController;

  Widget getCardForStatus(String status, Order order, bool enabled, int index) {
    Widget card;
    switch (status) {
      case OrderStatus.PENDING:
        card = PendingOrderCard(order: order, isCardEnabled: enabled);
        break;
      case OrderStatus.WAITING_FOR_PAYMENT:
        card = WaitingForPaymentCard(order: order, isCardEnabled: enabled);
        break;
      case OrderStatus.WAITING_FOR_DELIVERY:
        card = WaitingForDeliveryCard(order: order, isCardEnabled: enabled);
        break;
      case OrderStatus.DELIVERY_IN_PROGRESS:
        card = DeliveryInProgressCard(
            order: order,
            isCardEnabled: enabled,
            orderStatusDetail: _statusHistory[index]);
        break;
      case OrderStatus.COMPLETED:
        card = OrderDeliveredCard(order: order, isCardEnabled: enabled);
        break;
      case OrderStatus.CANCELLED_BY_CUSTOMER:
        card =
            OrderCanceledByCustomerCard(order: order, isCardEnabled: enabled);
        break;
      case 'canceled':
        card =
            OrderCanceledByCustomerCard(order: order, isCardEnabled: enabled);
        break;
      case OrderStatus.CANCELLED_BY_VENDOR:
        card = OrderCanceledByVendorCard(order: order, isCardEnabled: enabled);
        break;
      case OrderStatus.REJECTED:
        card = OrderRejectedCard(
            order: order,
            isCardEnabled: enabled,
            orderStatusDetail: _statusHistory[index]);
        break;
      case OrderStatus.VENDOR_PAYMENT_IN_PROGRESS:
        card = VendorPaymentInProgressCard(
            order: order,
            isCardEnabled: enabled,
            orderStatusDetail: _statusHistory[index]);
        break;
      case OrderStatus.VENDOR_PAYMENT_SUCCESSFUL:
        card = PaymentSuccessfulCard(order: order, isCardEnabled: enabled);
        break;
    }
    return card;
  }

  Row _buildDivider() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 1.0,
          height: 16.0,
          color: Colors.grey,
          margin: EdgeInsets.symmetric(vertical: 8.0),
        )
      ],
    );
  }

  @override
  void initState() {
    _scrollController = ScrollController(initialScrollOffset: 1000);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      semanticChildCount: _statusHistory.length,
      slivers: <Widget>[
        SliverOverlapInjector(
          handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24.0,
            vertical: 16.0,
          ),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                Order _order = widget.order;
                bool enabled = false;
                final int itemIndex = index ~/ 2;
                if (index.isEven) {
                  if (itemIndex == (_statusHistory.length - 1)) enabled = true;
                  return getCardForStatus(_statusHistory[itemIndex].status,
                      _order, enabled, itemIndex);
                }
                return _buildDivider();
              },
              semanticIndexCallback: (Widget widget, int localIndex) {
                if (localIndex.isEven) {
                  return localIndex ~/ 2;
                }
                return null;
              },
              childCount: math.max(0, _statusHistory.length * 2 - 1),
//            delegate: SliverChildBuilderDelegate(
//              (context, index) {
//                Order _order;
//                if (index.isEven) {
//                  if (index == (_statusHistory.length - 1)) _order = widget.order;
//                  return getCardForStatus(_statusHistory[index].status, _order);
//                }
//                return _buildDivider();
//              },
//              semanticIndexCallback: (Widget widget, int localIndex) {
//                if (localIndex.isEven) {
//                  return localIndex ~/ 2;
//                }
//                return null;
//              },
//              childCount: _statusHistory.length*2-1,
//            ),
//          ),
            ),
          ),
        ),
      ],
    );
  }
}
