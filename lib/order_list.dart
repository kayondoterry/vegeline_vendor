import 'package:flutter/material.dart';
import 'package:vegeline_vendor/shared/alert_system.dart';

class OrderList extends StatefulWidget {
  OrderList({Key key}) : super(key: key);

  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList>
    with AutomaticKeepAliveClientMixin, AlertSystemMixin {
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
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(75.0), child: _buildProductsTitle()),
      ),

    );
  }

  Widget _buildProductsTitle() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(left: 12.0, right: 4.0, bottom: 12.0),
      child: Row(
        children: <Widget>[
          Text(
            'Orders',
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
              Icons.filter_list,
            ),
            color: Colors.white,
            onPressed: () async {
              await Navigator.pushNamed(context, '/orderFilter');
            },
          ),
        ],
      ),
    );
  }
}
