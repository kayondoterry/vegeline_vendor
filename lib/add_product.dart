import 'package:flutter/material.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Hero(
            tag: 'Peas1',
            child: Image(
              image: AssetImage('assets/images/peas.jpg'),
            ),
          )
        ],
      ),
    );
  }
}
