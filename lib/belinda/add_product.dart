import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:vegeline_vendor/belinda/vendor_product_form.dart';
import 'package:vegeline_vendor/belinda/search_result_product_tile.dart';
import 'package:vegeline_vendor/models/category.dart';
import 'package:vegeline_vendor/models/product.dart';
import 'package:vegeline_vendor/models/vendor.dart';
import 'package:vegeline_vendor/services/db_service.dart';
import 'package:vegeline_vendor/shared/alert_system.dart';
import 'package:vegeline_vendor/shared/constants.dart';
import 'package:vegeline_vendor/shared/dissmiss_keyboard.dart';

class AddProduct extends StatefulWidget {

  final Vendor vendor;

  AddProduct({Key key, this.vendor}) : super(key: key);

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct>
    with DismissKeyboard, AlertSystemMixin {
  DBService _db = DBService();

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<Product> _products = [];
  List<Product> _queryProucts = [];
  bool _isLoadingProducts = false;
  String _query = "";

  _openVendorProductForm(Product product) async {

    await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        isDismissible: false,
        builder: (BuildContext context) {
          return VendorProductForm(product: product, vendor: widget.vendor,);
        });
  }

  _filterWithQuery() {
    if (_query.isEmpty) {
      setState(() {
        _queryProucts = _products;
      });
      return;
    }
    final result = _products
        .where(
            (p) => p.productName.toLowerCase().startsWith(_query.toLowerCase()))
        .toList();
    setState(() {
      _queryProucts = result;
    });
  }

  _loadProducts() async {
    setState(() {
      _isLoadingProducts = true;
    });

    try {
      final _productsResult = await _db.getAllAvailableProducts();
      setState(() {
        _products = _productsResult;
        _queryProucts = _productsResult;
        _isLoadingProducts = false;
      });
    } catch (e) {
      setState(() {
        _isLoadingProducts = false;
      });
      print(e.toString());
      alertErrorWithScaffoldState(_scaffoldKey.currentState, e.toString());
    }


  }

  @override
  void initState() {
    _loadProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.grey[50],
        title: appBarTitle,
        centerTitle: true,
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.clear),
            iconSize: 32.0,
            onPressed: () {
              Navigator.pop(context, null);
            },
          )
        ],
      ),
      body: _isLoadingProducts
          ? Center(
              child: Text('Loading Available Products'),
            )
          : _products.length == 0
              ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                          'No available products. Check your internet connection'),
                      SizedBox(height: 5.0),
                      FlatButton(
                        onPressed: _loadProducts,
                        child: Text(
                          'Try Again',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : CustomScrollView(
                  slivers: <Widget>[
                    SliverAppBar(
                      floating: true,
                      snap: true,
                      backgroundColor: Colors.grey[50],
                      automaticallyImplyLeading: false,
                      title: _buildSearchBox(),
                    ),
                    SliverPadding(
                      padding: EdgeInsets.all(8.0),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
//                Product _product = Product(
//                    productName: 'Product ${index + 1}',
//                    productId: '${index + 1}',
//                    category: Category.categoryList[
//                        Random().nextInt(Category.categoryList.length - 1)],
//                    imageURL: '');
                          return SearchResultProductTile(
                            product: _queryProucts[index],
                            onPressed: (product) {
                              _openVendorProductForm(product);
                            },
                          );
                        }, childCount: _queryProucts.length),
                      ),
                    ),
                  ],
                ),
    );
  }

  Widget _buildSearchBox() {
    final inputBorder = const UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent),
    );

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Row(
        children: <Widget>[
          Icon(Icons.search),
          Expanded(
            child: TextField(
              onChanged: (val) {
                setState(() {
                  _query = val;
                });
                _filterWithQuery();
              },
              style: TextStyle(
                fontSize: 20.0,
              ),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 5.0),
                hintText: 'Search Here...',
                border: inputBorder,
                enabledBorder: inputBorder,
                focusedBorder: inputBorder,
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.filter_list),
          ),
        ],
      ),
    );
  }
}
