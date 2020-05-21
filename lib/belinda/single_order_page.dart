import 'package:flutter/material.dart';
import 'package:vegeline_vendor/belinda/order_detail.dart';
import 'package:vegeline_vendor/belinda/order_summary.dart';
import 'package:vegeline_vendor/models/order.dart';
import 'package:vegeline_vendor/services/db_service.dart';
import 'package:vegeline_vendor/shared/constants.dart';

class SingleOrderPage extends StatefulWidget {
  final String orderId;

  const SingleOrderPage({Key key, this.orderId}) : super(key: key);

  @override
  _SingleOrderPageState createState() => _SingleOrderPageState();
}

class _SingleOrderPageState extends State<SingleOrderPage> {
  DBService _db = DBService();

  Stream<Order> _orderStream;
  List<String> _tabTitles = ['Detail', 'Summary'];

  @override
  void initState() {
    _orderStream = _db.singleOrderStream(widget.orderId);
    super.initState();
  }

  Widget getScreen(AsyncSnapshot snapshot, Widget main) {
    return snapshot.hasError
        ? Center(
            child: Text('Error\n${snapshot.error}'),
          )
        : snapshot.connectionState == ConnectionState.waiting
            ? Center(
                child: Text('Loading Info'),
              )
            : main;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBarTitle,
        centerTitle: true,
        backgroundColor: Colors.grey[100],
        elevation: 0.0,
      ),
      body: DefaultTabController(
        length: _tabTitles.length,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                child: SliverAppBar(
                  title: Text(
                    'Order Info',
                    style: TextStyle(
                      fontSize: 36.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  elevation: 0.0,
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
                      tabs: _tabTitles
                          .map((String name) => Tab(
                                text: name,
                              ))
                          .toList()),
                ),
              ),
            ];
          },
          body: StreamBuilder<Order>(
            stream: _orderStream,
            builder: (context, snapshot) {
              return TabBarView(
                children: [
                  getScreen(
                    snapshot,
                    OrderDetail(order: snapshot.data),
                  ),
                  getScreen(
                    snapshot,
                    OrderSummary(order: snapshot.data),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

///TabBarView(
//children: [
//StreamBuilder(
//stream: _orderStream,
//builder: (context, snapshot) {
//return getScreen(
//snapshot,
//Center(
//child: Text('Order Detail'),
//),
//);
//},
//),
//StreamBuilder(
//stream: _orderStream,
//builder: (context, snapshot) {
//return getScreen(
//snapshot,
//Center(
//child: Text('Order Detail'),
//),
//);
//},
//),
//],
//),
