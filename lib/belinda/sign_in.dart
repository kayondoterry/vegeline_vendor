import 'package:flutter/material.dart';
import 'package:vegeline_vendor/services/auth_service.dart';
import 'package:vegeline_vendor/shared/alert_system.dart';
import 'package:vegeline_vendor/shared/constants.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> with AlertSystemMixin {

  AuthService _auth = AuthService();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _isSigningIn = false;

  String _email = "";
  String _password = "";

  void signIn() async{
    setState(() {
      _isSigningIn = true;
    });

    try{
      await _auth.signInWithEmailAndPassword(email: _email, password: _password);
    }catch(e){
      alertErrorWithScaffoldState(_scaffoldKey.currentState, e.toString());
    }

    setState(() {
      _isSigningIn = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.grey[50],
        elevation: 0.0,
        centerTitle: true,
        title: appBarTitle,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        'Sign In to get started',
                        style: TextStyle(
                          fontSize: 36.0,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30.0),
                TextFormField(
                  initialValue: _email,
                  enabled: !_isSigningIn,
                  onChanged: (val) => setState(() {
                    _email = val.trim();
                  }),
                  validator: (val) {
                    if (val.trim().isEmpty) return 'Enter your email';
                    return null;
                  },
                  decoration: textInputDecoration.copyWith(hintText: 'Email'),
                ),
                SizedBox(height: 15.0),
                TextFormField(
                  initialValue: _password,
                  enabled: !_isSigningIn,
                  onChanged: (val) => setState(() {
                    _password = val;
                  }),
                  validator: (val) {
                    if (val.isEmpty) return 'Enter password';
                    return null;
                  },
                  decoration:
                      textInputDecoration.copyWith(hintText: 'Password'),
                  obscureText: true,
                ),
                SizedBox(height: 30.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 15.0),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(21.0),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 12.0),
                        onPressed: _isSigningIn ? null :  () {
                          if(_formKey.currentState.validate()){
                            signIn();
                          }
                        },
                        child: Text(
                          _isSigningIn ? 'Signing In' : 'Sign In',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                FlatButton(
                  onPressed: _isSigningIn ? null : () {
                    Navigator.pushNamed(context, '/createAccount');
                  },
                  child: Text(
                    'Have No Account Yet?',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
