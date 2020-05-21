import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vegeline_vendor/belinda/home.dart';
import 'package:vegeline_vendor/belinda/sign_in.dart';
import 'package:vegeline_vendor/models/user.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:vegeline_vendor/models/vendor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vegeline_vendor/services/db_service.dart';

class AuthWrapper extends StatefulWidget {
  @override
  _AuthWrapperState createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  Widget _buildLoadingScreen() {
    return Scaffold(
      body: Center(
        child: SpinKitCircle(
          color: Colors.grey,
          size: 42.0,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    if (user is LoadingUser) {
      print('laoding screen');
      return _buildLoadingScreen();
    }
    if (user == null) {
      print('to sign in');
      return SignIn();
    }
    print('user in');
    return VendorWrapper();
  }
}

class VendorWrapper extends StatefulWidget {
  @override
  _VendorWrapperState createState() => _VendorWrapperState();
}

class _VendorWrapperState extends State<VendorWrapper> {
  Future<Vendor> _vendorFuture;
  DBService _db = DBService();

  String message = "";

  Widget _buildLoadingScreen() {
    return Scaffold(
      body: Center(
        child: SpinKitCircle(
          color: Colors.grey,
          size: 42.0,
        ),
      ),
    );
  }

  Future<Vendor> _getVendor() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      String vendorJsonString;
      bool vendorSaved;

      try {
        vendorJsonString = prefs.getString("vendor");
      } catch (e) {
        print(e.toString());
        vendorJsonString = null;
      }

      try {
        vendorSaved = prefs.getBool("vendorSaved");
      } catch (e) {
        print(e.toString());
        vendorSaved = false;
      }

      Vendor vendor;
      String vendorId = Provider.of<User>(context).userId;

      if (vendorJsonString != null) {
        vendor = Vendor.fromJson(jsonDecode(vendorJsonString));

        if (!vendorSaved) {
          vendor.vendorId = vendorId;
          await _db.addVendor(vendor);
          print('not vendor saved-----sign up');
          print(vendor);
          await prefs.setString("vendor", jsonEncode(vendor.toJson()));
          prefs.setBool("vendorSaved", true);
        }
      } else {
        vendor = await _db.getVendor(vendorId);
        print('no local vendor-----sign in');
        print(vendor);
        await prefs.setString("vendor", jsonEncode(vendor.toJson()));
        prefs.setBool("vendorSaved", true);
      }
      return vendor;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  @override
  void initState() {
    _vendorFuture = _getVendor();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Vendor>(
      future: _vendorFuture,
      builder: (BuildContext context, AsyncSnapshot<Vendor> snapshot) {
        if (snapshot.hasError)
          return Scaffold(
            body: Center(
              child: Text(
                  'Something went wrong. Check your Network Connetion and Restart the Application\n${snapshot.error.toString()}'),
            ),
          );
        if (snapshot.connectionState != ConnectionState.done)
          return _buildLoadingScreen();
        return Provider<Vendor>.value(
          value: snapshot.data,
          child: Home(),
        );
      },
    );
  }
}
