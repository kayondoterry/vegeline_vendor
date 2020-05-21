import 'package:flutter/material.dart';

class OrderListFilter extends StatefulWidget {
  @override
  _OrderListFilterState createState() => _OrderListFilterState();
}

class _OrderListFilterState extends State<OrderListFilter> {
  Set<String> categories = Set<String>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black87,
        title: Text(
          'Sort and Filter Orders',
          style: TextStyle(
            letterSpacing: 1.5,
            fontWeight: FontWeight.w400,
          ),
        ),
        elevation: 0.0,
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            floating: true,
            snap: true,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FlatButton(
                  child: Text('CLEAR'),
                  onPressed: () async {},
                ),
                RaisedButton(
                  child: Text('APPLY'),
                  onPressed: () {},
                  color: Colors.black54,
                  textColor: Colors.grey[200],
                ),
              ],
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.all(12.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  Text(
                    'Category',
                    style: TextStyle(fontSize: 22.0),
                  ),
                  _buildAllCheckboxListTile(),
                  _buildCheckboxListTile('Meats'),
                  _buildCheckboxListTile('Grains'),
                  _buildCheckboxListTile('Poultry'),
                  _buildCheckboxListTile('Fruits and Vegetables'),
                  _buildCheckboxListTile('Dairy'),
                  _buildCheckboxListTile('That other one'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  CheckboxListTile _buildCheckboxListTile(String category) {
    return CheckboxListTile(
                  title: Text(category),
                  activeColor: Colors.black54,
                  value: categories.contains(category),
                  onChanged: (val) {
                    setState(() {
                      if (val)
                        categories..add(category);
                      else
                        categories.remove(category);
                    });
                  },
                );
  }

  CheckboxListTile _buildAllCheckboxListTile() {
    return CheckboxListTile(
                  title: Text('All'),
                  activeColor: Colors.black54,
                  value: categories.length == 6,
                  onChanged: (val) {
                    setState(() {
                      if (val)
                        categories
                          ..add('Meats')
                          ..add('Grains')
                          ..add('Fruits and Vegetables')
                          ..add('Dairy')
                          ..add('Poultry')
                          ..add('That other one');
                      else
                        categories.clear();
                    });
                  },
                );
  }
}
