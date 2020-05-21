import 'package:flutter/material.dart';
import 'package:vegeline_vendor/belinda/status_cards/delivery_in_progress_card.dart';
import 'package:vegeline_vendor/belinda/status_cards/order_canceled_by_customer_card.dart';
import 'package:vegeline_vendor/belinda/status_cards/order_delivered_card.dart';
import 'package:vegeline_vendor/belinda/status_cards/pending_order_card.dart';
import 'package:vegeline_vendor/belinda/status_cards/waiting_for_delivery_card.dart';
import 'package:vegeline_vendor/belinda/status_cards/waiting_for_payment.dart';
import 'package:vegeline_vendor/shared/constants.dart';

class CardList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBarTitle,
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        reverse: true,
        padding: EdgeInsets.symmetric(
          horizontal: 32.0,
          vertical: 16.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            PendingOrderCard(),
            _buildDivider(),
            WaitingForPaymentCard(),
            _buildDivider(),
            WaitingForDeliveryCard(),
            _buildDivider(),
            DeliveryInProgressCard(),
            _buildDivider(),
            OrderDeliveredCard(),
            _buildDivider(),
            OrderCanceledByCustomerCard(),
          ],
        ),
      ),
    );
  }

  Row _buildDivider() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 1.0,
          height: 48.0,
          color: Colors.grey,
          margin: EdgeInsets.symmetric(vertical: 8.0),
        )
      ],
    );
  }
}
