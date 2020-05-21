import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:vegeline_vendor/shared/dissmiss_keyboard.dart';

class ProductSelect extends StatefulWidget {
  ProductSelect({Key key}) : super(key: key);

  @override
  _ProductSelectState createState() => _ProductSelectState();
}

class _ProductSelectState extends State<ProductSelect> with DismissKeyboard {
  bool isUpdatingProducts = false;

  Future<void> _updateProducts() async {
    setState(() {
      isUpdatingProducts = true;
    });

    await Future.delayed(Duration(seconds: 4));

    setState(() {
      isUpdatingProducts = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black87,
        title: Text(
          'Select Product',
          style: TextStyle(
            letterSpacing: 2.0,
            fontWeight: FontWeight.w400,
          ),
        ),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {
              Navigator.pop(context, null);
            },
          )
        ],
//        bottom: PreferredSize(
//            preferredSize: Size.fromHeight(75.0), child: _buildSearchBar()),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            floating: true,
            snap: true,
            backgroundColor: Colors.black87,
            automaticallyImplyLeading: false,
            title: _buildSearchBar(),
          ),
          SliverPadding(
            padding: EdgeInsets.all(8.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                ...List.generate(
                    30, (index) => _buildProductListTile(context, index))
              ]),
            ),
          ),
        ],
      ),
//      SingleChildScrollView(
//        child: Padding(
//          padding: const EdgeInsets.all(8.0),
//          child: Column(
//            children: <Widget>[
//              ...List.generate(30, (index) => _buildProductListTile(context, index))
//            ],
//          ),
//        ),
//      ),
    );
  }

  Widget _buildProductListTile(BuildContext context, int index) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/addProduct');
      },
      child: Card(
        child: Row(
          children: <Widget>[
            Hero(
              tag: 'Peas$index',
              child: Image(
                image: AssetImage(
                  index.isEven
                      ? 'assets/images/peas.jpg'
                      : 'assets/images/meat.jpg',
                ),
                height: 80.0,
                width: 80.0,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Text('Peas $index'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                hintText: 'Search Products',
                border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)),
              ),
            ),
          ),
          isUpdatingProducts
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SpinKitCircle(
                    color: Colors.black87,
                    size: 25.0,
                  ),
                )
              : IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    dismissKeyboard(context);
                    _updateProducts();
                  },
                  color: Colors.black87,
                )
        ],
      ),
    );
  }
}
