import 'package:flutter/material.dart';

class PaymentList extends StatefulWidget {

  const PaymentList({Key key}) : super(key: key);

  @override
  _PaymentListState createState() => _PaymentListState();
}

class _PaymentListState extends State<PaymentList> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Center(
        child: Text('Payments'),
      ),
    );
  }
  @override
  bool get wantKeepAlive => true;
}
