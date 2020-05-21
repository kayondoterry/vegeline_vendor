import 'package:flutter/material.dart';
import 'package:vegeline_vendor/shared/alert_system.dart';

class ProductList extends StatefulWidget {
  ProductList({Key key}) : super(key: key);

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList>
    with AlertSystemMixin, AutomaticKeepAliveClientMixin {
  bool isUpdatingProducts = false;

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text(
          'VEGE-LINE',
          style: TextStyle(
            /**/
            letterSpacing: 2.0,
            fontWeight: FontWeight.w400,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
        elevation: 0.0,
        centerTitle: true,
//        bottom: PreferredSize(
//            preferredSize: Size.fromHeight(75.0), child: _buildProductsTitle()),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'productAddFab',
        backgroundColor: Colors.black54,
        onPressed: () async {
          final addedProduct =
              await Navigator.pushNamed(context, '/productSelect');
          if (addedProduct == null) {
            alertMessageWithScaffoldState(_scaffoldKey.currentState, 'No product added');
          }
        },
        child: Icon(
          Icons.add,
        ),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            floating: true,
            snap: true,
            backgroundColor: Colors.black87,
            automaticallyImplyLeading: false,
            title: _buildProductsTitle(),
          ),
          SliverPadding(
            padding: EdgeInsets.all(8.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate([]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductsTitle() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only( bottom: 4.0),
      child: Row(
        children: <Widget>[
          Text(
            'Products',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 28.0,
              letterSpacing: 1.5,
            ),
          ),
          Spacer(),
          IconButton(
            icon: Icon(
              Icons.refresh,
            ),
            color: Colors.white,
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.filter_list,
            ),
            color: Colors.white,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
