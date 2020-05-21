import 'package:flutter/material.dart';
import 'package:vegeline_vendor/models/product.dart';
import 'package:vegeline_vendor/models/vendor.dart';
import 'package:vegeline_vendor/models/vendor_product.dart';
import 'package:vegeline_vendor/services/db_service.dart';
import 'package:vegeline_vendor/shared/alert_system.dart';

class VendorProductForm extends StatefulWidget {
  final Product product;
  final Vendor vendor;
  final VendorProduct initialVendorProduct;

  const VendorProductForm(
      {Key key, @required this.product, this.vendor, this.initialVendorProduct})
      : super(key: key);

  @override
  _VendorProductFormState createState() => _VendorProductFormState();
}

class _VendorProductFormState extends State<VendorProductForm>
    with AlertSystemMixin {
  DBService _db = DBService();

  Product _product;
  Vendor _vendor;
  VendorProduct _initialVendorProduct;
  double _priceDigits;

  bool _isProductAdded = false;
  bool _isSavingVendorProduct = false;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  _saveVendorProduct() async {
//    Vendor vendor = Provider.of<Vendor>(context, listen: false);
    setState(() {
      _isSavingVendorProduct = true;
    });
    try {
      final serviceRate = await _db.getServiceRate();

      final serviceFeeIntermediate =
          ((serviceRate / 100) * _priceDigits).floor().toDouble();
      final serviceFee =
          serviceFeeIntermediate + (100 - (serviceFeeIntermediate % 100));

      VendorProduct vendorProduct = VendorProduct(
          vendor: _vendor,
          vendorProductId: '${_vendor.vendorId}_${_product.productId}',
          price: _priceDigits,
          product: _product,
          serviceFee: serviceFee);
      if (_initialVendorProduct == null) {
        await _db.addVendorProduct(vendorProduct);
      } else {
        await _db.updateVendorProduct(vendorProduct);
      }
      setState(() {
        _isSavingVendorProduct = false;
        _isProductAdded = true;
      });
      await Future.delayed(Duration(milliseconds: 1000));
      Navigator.pop(context);
    } catch (e) {
      setState(() {
        _isSavingVendorProduct = false;
      });
      print(e.toString());
      alertErrorWithScaffoldState(_scaffoldKey.currentState, e.toString());
    }
  }

  bool _valueChanged() {
    if (_initialVendorProduct == null) return true;
    return _initialVendorProduct.price != _priceDigits;
  }

  String _getInitialPrice() {
    if (_initialVendorProduct != null)
      return _initialVendorProduct.price.toInt().toString();
    return "";
  }

  @override
  void initState() {
    _product = widget.product;
    _vendor = widget.vendor;
    _initialVendorProduct = widget.initialVendorProduct;
    if (_initialVendorProduct != null)
      _priceDigits = _initialVendorProduct.price;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: SingleChildScrollView(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom, top: 25.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            '${_product.productName}',
                            style: TextStyle(
                              fontSize: 22.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.clear),
                          onPressed: () {
                            if (!_isProductAdded && !_isSavingVendorProduct)
                              Navigator.pop(context);
                          },
                        )
                      ],
                    ),
                    SizedBox(height: 15.0),
                    TextFormField(
                      initialValue: _getInitialPrice(),
                      enabled: !_isProductAdded && !_isSavingVendorProduct,
                      validator: (val) {
                        if (val.trim().isEmpty) return 'Enter Price';
                        if (double.tryParse(val.trim()) == null)
                          return 'Invalid input';
                        return null;
                      },
                      onChanged: (val) {
                        setState(() {
                          _priceDigits = double.tryParse(val.trim());
                        });
                      },
                      onFieldSubmitted: (val) {
                        if (_formKey.currentState.validate()) {
                          _saveVendorProduct();
                        }
                      },
                      keyboardType: TextInputType.numberWithOptions(
                          decimal: false, signed: false),
                      style: TextStyle(fontSize: 20.0),
                      decoration: InputDecoration(
                          hintText: 'Choose a price for this product',
                          labelText: 'Price'),
                    ),
                    SizedBox(height: 40.0),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 15.0),
                      child: RaisedButton(
                        color:
                            _isProductAdded ? Colors.green : Colors.yellow[600],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(21.0),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 12.0),
                        onPressed: _isSavingVendorProduct || !_valueChanged()
                            ? null
                            : () {
                                if (!_isProductAdded) {
                                  if (_formKey.currentState.validate()) {
                                    _saveVendorProduct();
                                  }
                                }
                              },
                        child: Text(
                          _isProductAdded
                              ? 'Product Saved!'
                              : _isSavingVendorProduct
                                  ? 'Saving Product'
                                  : 'Save Product',
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 20.0,
                              color: _isProductAdded
                                  ? Colors.white
                                  : Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
              ), // From with TextField inside
            )),
      ),
    );
  }
}
