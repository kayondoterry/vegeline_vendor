import 'package:flutter/material.dart';
import 'package:vegeline_vendor/drawer.dart';
import 'package:vegeline_vendor/order_list.dart';
import 'package:vegeline_vendor/product_list.dart';

class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  PageController _pageController;
  int currentPageIndex = 0;

  onItemClicked(int index) {
    _pageController.jumpToPage(index);
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        drawer: LeftSideDrawer(
          onItemClicked: onItemClicked,
        ),
        body: PageView(
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            ProductList(),
            OrderList(),
          ],
        ));
  }
}
