import 'package:flutter/material.dart';
import 'package:vegeline_vendor/models/product.dart';

class SearchResultProductTile extends StatelessWidget {
  final Product product;
  final Function onPressed;

  const SearchResultProductTile({Key key, @required this.product, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onPressed != null) {
          onPressed(product);
        }
      },
      child: Card(
        child: Row(
          children: <Widget>[
            Image(
              image: NetworkImage(product.imageURL),
              height: 80.0,
              width: 80.0,
              fit: BoxFit.cover,
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  ListTile(
                    title: Text('${product.productName}'),
                    subtitle: Text('${product.category}\n'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}