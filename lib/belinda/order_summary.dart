import 'package:flutter/material.dart';
import 'package:vegeline_vendor/models/order.dart';

class OrderSummary extends StatelessWidget {
  final Order order;

  const OrderSummary({Key key, this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverPadding(
          padding: const EdgeInsets.all(16.0),
          sliver: SliverToBoxAdapter(
            child: Column(
              children: <Widget>[
                Row(
                  children: [
                    Text(
                      'Item Details',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    SizedBox(width: 5.0),
                    Expanded(
                      child: Divider(thickness: 1.0),
                    ),
                  ],
                ),
                SizedBox(height: 15.0),
                Row(
                  children: [
                    Text(
                      'Food Item',
                      style: TextStyle(
                        fontSize: 19.0,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '${order.vendorProduct.product.productName}',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontSize: 17.0,
                        ),
                      ),
                    )
                  ],
                ),
                Divider(height: 30.0),
                Row(
                  children: [
                    Text(
                      'Unit Price',
                      style: TextStyle(
                        fontSize: 19.0,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '${order.vendorProduct.price}/= per ${order.vendorProduct.product.standardUnit}',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontSize: 17.0,
                        ),
                      ),
                    )
                  ],
                ),
                Divider(height: 30.0),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Quantity',
                        style: TextStyle(
                          fontSize: 19.0,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '${order.quantity}',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontSize: 17.0,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 25.0),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      text: 'Total Cost   ',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 22.0,
                      ),
                      children: [
                        TextSpan(
                          text:
                              '${order.quantity * order.vendorProduct.price}/=',
                          style: TextStyle(
                            color: Colors.green,
                          ),
                        ),
                      ]),
                ),
                SizedBox(height: 30.0),
              ],
            ),
          ),
        )
      ],
    );
  }
}
