import 'package:flutter/material.dart';
import 'package:vegeline_vendor/belinda/vendor_product_form.dart';
import 'package:vegeline_vendor/models/product.dart';
import 'package:vegeline_vendor/models/vendor_product.dart';
import 'package:vegeline_vendor/services/db_service.dart';

class VendorProductDetail extends StatefulWidget {
  final VendorProduct vendorProduct;

  const VendorProductDetail({Key key, this.vendorProduct}) : super(key: key);

  @override
  _VendorProductDetailState createState() => _VendorProductDetailState();
}

class _VendorProductDetailState extends State<VendorProductDetail> {
  DBService _db = DBService();

  VendorProduct _vendorProduct;

  @override
  void initState() {
    _vendorProduct = widget.vendorProduct;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      floatingActionButton: EditVendorProductFAB(vendorProduct: _vendorProduct),
      body: StreamBuilder<VendorProduct>(
          stream: _db.singleVendorProductStream(_vendorProduct.vendorProductId),
          initialData: _vendorProduct,
          builder: (context, snapshot) {
            VendorProduct vendorProduct = snapshot.data;

            return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Image(
                    image: NetworkImage(vendorProduct.product.imageURL),
                    fit: BoxFit.cover,
                    height: 300.0,
                    width: MediaQuery.of(context).size.width,
                  ),
                  SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                '${vendorProduct.product.productName}',
                                style: TextStyle(
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            EditVendorProductButton(
                              vendorProduct: vendorProduct,
                            ),
                          ],
                        ),
                        Divider(),
                        Row(
                          children: <Widget>[
                            Text('Price', style: TextStyle(fontSize: 24.0)),
                            Spacer(),
                            Text(
                              '${vendorProduct.price}',
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
//                      SizedBox(width: 10.0),
//                      IconButton(
//                        onPressed: () {},
//                        icon: Icon(Icons.edit),
//                      ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}

class EditVendorProductButton extends StatefulWidget {
  final VendorProduct vendorProduct;

  const EditVendorProductButton({Key key, this.vendorProduct})
      : super(key: key);

  @override
  _EditVendorProductButtonState createState() =>
      _EditVendorProductButtonState();
}

class _EditVendorProductButtonState extends State<EditVendorProductButton> {
  VendorProduct _vendorProduct;

  _openVendorProductForm() async {
    await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        isDismissible: false,
        builder: (BuildContext context) {
          return VendorProductForm(
            product: _vendorProduct.product,
            vendor: _vendorProduct.vendor,
            initialVendorProduct: _vendorProduct,
          );
        });
  }

  @override
  void initState() {
    _vendorProduct = widget.vendorProduct;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        _openVendorProductForm();
      },
      child: Icon(Icons.edit),
    );
  }
}

//class EditVendorProductFAB extends StatefulWidget {
//  final VendorProduct vendorProduct;
//
//  const EditVendorProductFAB({Key key, this.vendorProduct}) : super(key: key);
//
//  @override
//  _EditVendorProductFABState createState() => _EditVendorProductFABState();
//}
//
//class _EditVendorProductFABState extends State<EditVendorProductFAB> {
//  VendorProduct _vendorProduct;
//  bool _isFABVisible = true;
//
//  _openVendorProductForm(Product product) async {
//    setState(() {
//      _isFABVisible = false;
//    });
//    await showModalBottomSheet(
//        context: context,
//        isScrollControlled: true,
//        isDismissible: false,
//        builder: (BuildContext context) {
//          return VendorProductForm(product: product);
//        });
//    setState(() {
//      _isFABVisible = true;
//    });
//  }
//
//  @override
//  void initState() {
//    _vendorProduct = widget.vendorProduct;
//    super.initState();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return _isFABVisible
//        ? FloatingActionButton(
//            onPressed: () {
//              _openVendorProductForm(_vendorProduct.product);
//            },
//            child: Icon(Icons.edit),
//          )
//        : Container(height: 0.0, width: 0.0);
//  }
//}
