import 'package:flutter/material.dart';
import 'package:vegeline_vendor/belinda/vendor_product_tile.dart';
import 'package:vegeline_vendor/models/vendor_product.dart';


class VendorProductListForCategory extends StatelessWidget {
  final String categoryName;
  final List<VendorProduct> vendorProductList;
  final Function onPressed;

  const VendorProductListForCategory({Key key, this.vendorProductList, this.onPressed, this.categoryName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return vendorProductList.isEmpty ? Center(child: Text('No products in this category'),) : SafeArea(
      top: false,
      bottom: false,
      child: Builder(
        // This Builder is needed to provide a BuildContext that is "inside"
        // the NestedScrollView, so that sliverOverlapAbsorberHandleFor() can
        // find the NestedScrollView.
        builder: (BuildContext context) {
          return CustomScrollView(
            // The "controller" and "primary" members should be left
            // unset, so that the NestedScrollView can control this
            // inner scroll view.
            // If the "controller" property is set, then this scroll
            // view will not be associated with the NestedScrollView.
            // The PageStorageKey should be unique to this ScrollView;
            // it allows the list to remember its scroll position when
            // the tab view is not on the screen.
            key: PageStorageKey<String>(categoryName),
            slivers: <Widget>[
              SliverOverlapInjector(
                // This is the flip side of the SliverOverlapAbsorber above.
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              ),
              SliverPadding(
                  padding: const EdgeInsets.all(8.0),
                  // In this example, the inner scroll view has
                  // fixed-height list items, hence the use of
                  // SliverFixedExtentList. However, one could use any
                  // sliver widget here, e.g. SliverList or SliverGrid.
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return VendorProductTile(
                          onPressed: onPressed,
                          vendorProduct: vendorProductList[index],
                        );
                      },
                      childCount: vendorProductList.length
                    ),
                  )),
            ],
          );
        },
      ),
    );
  }
}
