import 'package:flutter/material.dart';
import 'package:vegeline_vendor/models/order.dart';
import 'package:vegeline_vendor/models/order_status.dart';
import 'package:vegeline_vendor/models/order_status_detail.dart';
import 'package:vegeline_vendor/services/db_service.dart';
import 'package:vegeline_vendor/shared/alert_system.dart';
import 'package:vegeline_vendor/shared/constants.dart';
import 'package:vegeline_vendor/shared/dissmiss_keyboard.dart';

class OrderDeliveredCard extends StatefulWidget {
  final Order order;
  final bool isCardEnabled;

  const OrderDeliveredCard({Key key, this.order, this.isCardEnabled}) : super(key: key);

  @override
  _OrderDeliveredCardState createState() => _OrderDeliveredCardState();
}

class _OrderDeliveredCardState extends State<OrderDeliveredCard> with AlertSystemMixin, DismissKeyboard {
  DBService _db = DBService();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isSubmittingData = false;
  bool _dataSubmitted = false;
  bool _isFormVisible = true;

  String _phoneNumber = "";


  bool get _isDisabled => !widget.isCardEnabled;

  void _submitData()async{
    if (_formKey.currentState.validate()) {
      dismissKeyboard(context);
      try {
        setState(() {
          _isSubmittingData = true;
        });

        OrderStatusDetail statusDetail = OrderStatusDetail(
            status: OrderStatus.VENDOR_PAYMENT_IN_PROGRESS, dataField: _phoneNumber);
        await _db.updateOrderStatus(widget.order, statusDetail);
        setState(() {
          _dataSubmitted = true;
        });
      } catch (e, s) {
        print(s);
        alertErrorWithContext(context, e.toString());
      } finally {
        setState(() {
          _isSubmittingData = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(8.0),
              color: Colors.grey[600],
              child: Text(
                'ORDER DELIVERED',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey[200]),
              ),
            ),
            _isDisabled ? Container(height: 0,width: 0) : Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    '$MESSAGE_COMPLETED',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, right: 16.0, bottom: 8.0, top: 16.0),
                    child: TextFormField(
                      validator: (val) {
                        // TODO: validate legit MTN phone number (e.g starts with 077, 078, etc (research valid MTN phone numbers))
                        if (val.trim().isEmpty)
                          return "Enter Airtel Phone Number";
                        if (val.trim().length != 10)
                          return "Phone Number should be 10 digits long";
                        return null;
                      },
                      onChanged: (val) {
                        setState(() {
                          _phoneNumber = val.trim();
                        });
                      },
                      decoration:
                      InputDecoration(hintText: 'Airtel Phone Number'),
                    )
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
                  child: ButtonBar(
                    children: [
                      RaisedButton(
                        onPressed:
                        (_isDisabled || _isSubmittingData || _dataSubmitted)
                            ? null
                            : _submitData,
                        child:
                        Text(_isSubmittingData ? 'SUBMITTING' : 'SUBMIT'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
