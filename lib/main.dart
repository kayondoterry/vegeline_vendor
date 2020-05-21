import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vegeline_vendor/belinda/add_product.dart';
import 'package:vegeline_vendor/belinda/auth_wrapper.dart';
import 'package:vegeline_vendor/belinda/sign_up.dart';
import 'package:vegeline_vendor/belinda/single_order_page.dart';
import 'package:vegeline_vendor/belinda/vendor_product_detail.dart';
import 'package:vegeline_vendor/models/user.dart';
import 'package:vegeline_vendor/services/auth_service.dart';
import 'package:vegeline_vendor/shared/dissmiss_keyboard.dart';

//import 'package:vegeline_vendor/product_select.dart';
//import 'package:vegeline_vendor/main_app.dart';
//import 'package:vegeline_vendor/order_list_filter.dart';
//import 'package:vegeline_vendor/add_product.dart';
//import 'package:vegeline_vendor/sign_up.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget with DismissKeyboard {
  AuthService _auth = AuthService();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        dismissKeyboard(context);
      },
      child: StreamProvider<User>.value(
        value: _auth.currentUserStream,
        initialData: LoadingUser(),
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.grey,
            accentColor: Colors.yellow[600],
            buttonColor: Colors.yellow[600],
          ),
          routes: {
//          '/': (context) => SignUp(),
//          '/productSelect': (context) => ProductSelect(),
//          '/orderFilter': (context) => OrderListFilter(),
//          '/addProduct': (context) => AddProduct(),
//          '/mainApp': (context) => MainApp(),
            '/': (context) => AuthWrapper(),
            '/createAccount': (context) => SignUp(),
//            '/home': (context) => Home(),

          },
          onGenerateRoute: (settings) {
            switch (settings.name) {
              case '/vendorProductDetail':
                return MaterialPageRoute(builder: (context) {
                  return VendorProductDetail(vendorProduct: settings.arguments);
                });
                break;
              case '/addProduct':
                return MaterialPageRoute(builder: (context) {
                  return AddProduct(vendor: settings.arguments,);
                });
                break;
              case '/orderDetail':
                return MaterialPageRoute(builder: (context) {
                  return SingleOrderPage(
                    orderId: settings.arguments,
                  );
                });
                break;
              default:
                return null;
            }
          },
        ),
      ),
    );
  }
}
