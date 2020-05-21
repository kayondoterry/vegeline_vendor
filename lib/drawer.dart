import 'package:flutter/material.dart';

class LeftSideDrawer extends StatefulWidget {
  final Function onItemClicked;

  LeftSideDrawer({Key key, this.onItemClicked}) : super(key: key);

  @override
  _LeftSideDrawerState createState() => _LeftSideDrawerState();
}

class _LeftSideDrawerState extends State<LeftSideDrawer> {
  void _handleItemClick(int index) {
    if (widget.onItemClicked != null) {
      widget.onItemClicked(index);
    }
    Navigator.pop(context);
  }

  final _drawerItemTextStyle = const TextStyle(
    fontSize: 18.0,
  );

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      width: screenWidth * 0.8,
      child: Drawer(
        child: Column(
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.black87),
              child: Center(
                child: Text(
                  'Vege Line',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 36.0,
                      fontFamily: 'Cursive',
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            ListTile(
              title: Text(
                'Products',
                style: _drawerItemTextStyle,
              ),
              onTap: () {
                _handleItemClick(0);
              },
            ),
            ListTile(
              title: Text(
                'Orders',
                style: _drawerItemTextStyle,
              ),
              onTap: () {
                _handleItemClick(1);
              },
            ),
            ListTile(
              title: Text(
                'Notifications',
                style: _drawerItemTextStyle,
              ),
              onTap: () {},
            ),
            SizedBox(height: 20.0),
            ListTile(
              title: Text(
                'About',
                style: _drawerItemTextStyle,
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
