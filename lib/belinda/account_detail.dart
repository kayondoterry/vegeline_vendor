import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vegeline_vendor/services/auth_service.dart';
import 'package:vegeline_vendor/shared/constants.dart';

class AccountDetail extends StatefulWidget {
  const AccountDetail({Key key}) : super(key: key);

  @override
  _AccountDetailState createState() => _AccountDetailState();
}

class _AccountDetailState extends State<AccountDetail>
    with AutomaticKeepAliveClientMixin {
  AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: appBarTitle,
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.grey[100],
      ),
      body: Center(
          child: FlatButton(
        onPressed: () async{
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.remove("vendor");
          await prefs.remove("vendorSaved");
          _auth.signOut();
        },
        child: Text('Sign Out'),
      )),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
