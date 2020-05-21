import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  static const _textFieldBorder = OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey),
  );

  final _textFieldDecoration = InputDecoration(
      labelStyle: TextStyle(
        color: Colors.white,
      ),
      hintStyle: TextStyle(
        color: Colors.grey,
      ),
      border: _textFieldBorder,
      focusedBorder: _textFieldBorder.copyWith(
          borderSide: BorderSide(color: Colors.grey[100])),
      enabledBorder: _textFieldBorder);

  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: SafeArea(
          child: PageView(
        controller: _pageController,
        children: <Widget>[
          SignInPage(textFieldDecoration: _textFieldDecoration),
          SignUpPage(textFieldDecoration: _textFieldDecoration),
        ],
      )),
    );
  }
}

class SignUpPage extends StatelessWidget {
  const SignUpPage({
    Key key,
    @required InputDecoration textFieldDecoration,
  })  : _textFieldDecoration = textFieldDecoration,
        super(key: key);

  final InputDecoration _textFieldDecoration;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(16.0),
//              height: MediaQuery.of(context).size.height,
              child: Form(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          'Sign Up',
                          style: TextStyle(
                              color: Colors.grey[200],
                              fontSize: 42.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(height: 40.0),
                    TextFormField(
                      style: TextStyle(color: Colors.grey[200]),
                      decoration:
                          _textFieldDecoration.copyWith(hintText: 'Full Name'),
                    ),
                    SizedBox(height: 8.0),
                    TextFormField(
                      obscureText: true,
                      style: TextStyle(color: Colors.grey[200]),
                      decoration:
                          _textFieldDecoration.copyWith(hintText: 'password'),
                    ),
                    SizedBox(height: 8.0),
                    TextFormField(
                      style: TextStyle(color: Colors.grey[200]),
                      decoration:
                          _textFieldDecoration.copyWith(hintText: 'email'),
                    ),
                    SizedBox(height: 8.0),
                    TextFormField(
                      obscureText: true,
                      style: TextStyle(color: Colors.grey[200]),
                      decoration:
                          _textFieldDecoration.copyWith(hintText: 'password'),
                    ),
                    SizedBox(height: 8.0),
                    TextFormField(
                      style: TextStyle(color: Colors.grey[200]),
                      decoration:
                          _textFieldDecoration.copyWith(hintText: 'email'),
                    ),
                    SizedBox(height: 8.0),
                    TextFormField(
                      obscureText: true,
                      style: TextStyle(color: Colors.grey[200]),
                      decoration:
                          _textFieldDecoration.copyWith(hintText: 'password'),
                    ),
                    SizedBox(height: 30.0),
                    RaisedButton(
                      child: Text('SIGN UP'),
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/mainApp');
                      },
                      padding: EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 32.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(23.0)),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    FlatButton(
                      onPressed: () {},
                      child: RichText(
                        text: TextSpan(
                          text: 'Already have an account? ',
                          children: [
                            TextSpan(
                                text: 'Sign In',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                )),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SignInPage extends StatelessWidget {
  const SignInPage({
    Key key,
    @required InputDecoration textFieldDecoration,
  })  : _textFieldDecoration = textFieldDecoration,
        super(key: key);

  final InputDecoration _textFieldDecoration;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(children: [
        SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        'Sign In',
                        style: TextStyle(
                            color: Colors.grey[200],
                            fontSize: 42.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 40.0),
                  TextFormField(
                    style: TextStyle(color: Colors.grey[200]),
                    decoration:
                        _textFieldDecoration.copyWith(hintText: 'Email'),
                  ),
                  SizedBox(height: 8.0),
                  TextFormField(
                    obscureText: true,
                    style: TextStyle(color: Colors.grey[200]),
                    decoration:
                        _textFieldDecoration.copyWith(hintText: 'Password'),
                  ),
                  SizedBox(height: 30.0),
                  RaisedButton(
                    child: Text('SIGN IN'),
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/mainApp');
                    },
                    padding:
                        EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(23.0)),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  FlatButton(
                    onPressed: () {},
                    child: RichText(
                      text: TextSpan(
                        text: 'Have no account? ',
                        children: [
                          TextSpan(
                              text: 'Sign Up',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              )),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
