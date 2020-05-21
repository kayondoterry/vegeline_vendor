import 'package:flutter/material.dart';
import 'package:vegeline_vendor/models/vendor_product.dart';

class VendorProductTile extends StatelessWidget {
  final VendorProduct vendorProduct;
  final Function onPressed;

  const VendorProductTile({Key key, this.vendorProduct, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        if (onPressed != null) onPressed(vendorProduct);
      },
      title: Text('${vendorProduct.product.productName}'),
      subtitle: Text('${vendorProduct.price}'),
    );
  }
}
