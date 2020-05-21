import 'package:flutter/material.dart';
import 'package:vegeline_vendor/belinda/account_detail.dart';
import 'package:vegeline_vendor/belinda/order_list.dart';
import 'package:vegeline_vendor/belinda/orders_page_2.dart';
import 'package:vegeline_vendor/belinda/payment_list.dart';
import 'package:vegeline_vendor/belinda/product_list.dart';
import 'package:vegeline_vendor/shared/constants.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _bottomNavItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.fastfood),
      title: Text('Products'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.add_shopping_cart),
      title: Text('Orders'),
    ),
//    BottomNavigationBarItem(
//      icon: Icon(Icons.monetization_on),
//      title: Text('Payments'),
//    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.account_circle),
      title: Text('Account'),
    ),
  ];

  int _currentIndex = 0;

  final _pages = [
    ProductList(),
    OrdersPage(),
//    PaymentList(),
    AccountDetail(),
  ];

  PageController _pageController = PageController();

  void _onTabPressed(int index) {
    _pageController.jumpToPage(index);
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: _bottomNavItems,
        currentIndex: _currentIndex,
        onTap: _onTabPressed,
        unselectedItemColor: Colors.grey,
        unselectedLabelStyle: TextStyle(
          color: Colors.grey,
        ),
        selectedItemColor: Colors.yellow[600],
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        showUnselectedLabels: true,
      ),
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        onPageChanged: _onPageChanged,
        children: _pages,
      ),
    );
  }
}
