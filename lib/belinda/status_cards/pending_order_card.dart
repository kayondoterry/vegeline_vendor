import 'package:flutter/material.dart';
import 'package:vegeline_vendor/models/order.dart';
import 'package:vegeline_vendor/services/db_service.dart';
import 'package:vegeline_vendor/shared/alert_system.dart';
import 'package:vegeline_vendor/shared/constants.dart';
import 'package:vegeline_vendor/models/order_status.dart';
import 'package:vegeline_vendor/models/order_status_detail.dart';
import 'package:vegeline_vendor/shared/dissmiss_keyboard.dart';

class PendingOrderCard extends StatefulWidget {
  final Order order;
  final bool isCardEnabled;

  const PendingOrderCard({Key key, this.order, this.isCardEnabled})
      : super(key: key);

  @override
  _PendingOrderCardState createState() => _PendingOrderCardState();
}

class _PendingOrderCardState extends State<PendingOrderCard>
    with AlertSystemMixin, DismissKeyboard {
  DBService _db = DBService();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isRejectingOrder = false;
  bool _isAcceptingOrder = false;
  bool _wantsToReject = false;
  bool _orderProcessed = false;

  String _reasonForRejection = "";

  bool get _isDisabled => !widget.isCardEnabled;

  void _rejectOrder() async {
    if (_wantsToReject) {
      if (_formKey.currentState.validate()) {
        dismissKeyboard(context);
        try {
          setState(() {
            _isRejectingOrder = true;
          });

          OrderStatusDetail statusDetail = OrderStatusDetail(
              status: OrderStatus.REJECTED, dataField: _reasonForRejection);
          await _db.updateOrderStatus(widget.order, statusDetail);
          setState(() {
            _orderProcessed = true;
          });
        } catch (e, s) {
          print(s);
          alertErrorWithContext(context, e.toString());
        } finally {
          setState(() {
            _isRejectingOrder = false;
          });
        }
      }
    } else {
      setState(() {
        _wantsToReject = true;
      });
    }
  }

  void _acceptOrder() async {
    dismissKeyboard(context);
    try {
      setState(() {
        _isAcceptingOrder = true;
      });

      OrderStatusDetail statusDetail =
          OrderStatusDetail(status: OrderStatus.WAITING_FOR_PAYMENT);
      await _db.updateOrderStatus(widget.order, statusDetail);
      setState(() {
        _orderProcessed = true;
      });
    } catch (e, s) {
      print(s);
      alertErrorWithContext(context, e.toString());
    } finally {
      setState(() {
        _isAcceptingOrder = false;
      });
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
                'ORDER PRENDING',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey[200]),
              ),
            ),
            _isDisabled
                ? Container(height: 0,width: 0)
                : Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0, right: 16.0, bottom: 8.0, top: 16.0),
                        child: Text(
                          '$MESSAGE_PENDING',
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
                        child: _wantsToReject
                            ? TextFormField(
                                validator: (val) {
                                  if (val.trim().isEmpty)
                                    return "Enter reason for rejecting order";
                                  return null;
                                },
                                onChanged: (val) {
                                  setState(() {
                                    _reasonForRejection = val.trim();
                                  });
                                },
                                decoration: InputDecoration(
                                    hintText: 'Reason for rejection'),
                              )
                            : Container(height: 0, width: 0),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
                        child: ButtonBar(
                          children: [
                            FlatButton(
                              onPressed: (_isDisabled ||
                                      _isRejectingOrder ||
                                      _orderProcessed)
                                  ? null
                                  : _rejectOrder,
                              child: Text(_isRejectingOrder
                                  ? 'REJECTING'
                                  : 'REJECT ORDER'),
                            ),
                            RaisedButton(
                              onPressed: (_isDisabled ||
                                      _isAcceptingOrder ||
                                      _orderProcessed)
                                  ? null
                                  : _acceptOrder,
                              child: Text(_isAcceptingOrder
                                  ? 'ACCEPTING'
                                  : 'ACCEPT ORDER'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
          ],
        ),
      ),
    );
  }
}
