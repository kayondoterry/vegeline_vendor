import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vegeline_vendor/belinda/vendor_product_list_for_category.dart';
import 'package:vegeline_vendor/models/category.dart';
import 'package:vegeline_vendor/models/product.dart';
import 'package:vegeline_vendor/models/vendor.dart';
import 'package:vegeline_vendor/models/vendor_product.dart';
import 'package:vegeline_vendor/belinda/fake_data.dart';
import 'package:vegeline_vendor/models/vendor_type.dart';
import 'package:vegeline_vendor/services/db_service.dart';
import 'package:vegeline_vendor/shared/constants.dart';

class ProductList extends StatefulWidget {
  const ProductList({Key key}) : super(key: key);

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList>
    with AutomaticKeepAliveClientMixin {
  DBService _db = DBService();

  List<String> _categories = [...Category.categoryList];
  List<Widget> _tabViews;
  Map<String, Stream<List<VendorProduct>>> _vendorProductStream = {};

  @override
  void initState() {
    final vendor = Provider.of<Vendor>(context, listen: false);

    _categories.forEach((category) => _vendorProductStream[category] =
        _db.vendorProductsByCategoryStream(vendor, category));

    _tabViews = _categories.map((String category) {
      return StreamBuilder<List<VendorProduct>>(
        stream: _vendorProductStream[category],
        builder: (BuildContext context,
            AsyncSnapshot<List<VendorProduct>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: Text('Loading Products'));

          if (snapshot.hasError)
            return Center(
                child: Text('Something went wrong. Restart Application'));

          return VendorProductListForCategory(
            onPressed: (VendorProduct vendorProduct) async {
              Navigator.pushNamed(
                context,
                '/vendorProductDetail',
                arguments: vendorProduct,
              );
            },
            categoryName: category,
            vendorProductList: snapshot.data
                .where(
                  (vendorProduct) => vendorProduct.product.category == category,
                )
                .toList(),
          );
        },
      );
    }).toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: appBarTitle,
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.grey[100],
      ),
      body: DefaultTabController(
        length: _categories.length,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                child: SliverAppBar(
                  title: Text(
                    'My Products',
                    style: TextStyle(
                      fontSize: 36.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  backgroundColor: Colors.grey[100],
                  floating: true,
                  snap: true,
                  automaticallyImplyLeading: false,
                  forceElevated: innerBoxIsScrolled,
                  bottom: TabBar(
                      isScrollable: true,
                      unselectedLabelColor: Colors.grey,
                      indicatorColor: Colors.black54,
                      indicatorWeight: 1.5,
                      labelStyle: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                      labelColor: Colors.black,
                      tabs: _categories
                          .map((String name) => Tab(
                                text: name,
                              ))
                          .toList()),
                  actions: <Widget>[
                    IconButton(
                      onPressed: () async {
                        await Navigator.pushNamed(context, '/addProduct',
                            arguments:
                                Provider.of<Vendor>(context, listen: false));
                      },
                      icon: Icon(Icons.add_circle_outline),
                      iconSize: 36.0,
                    )
                  ],
                ),
              ),
            ];
          },
          body: TabBarView(
            children: _tabViews,
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
