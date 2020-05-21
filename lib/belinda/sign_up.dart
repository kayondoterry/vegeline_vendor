import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vegeline_vendor/models/vendor.dart';
import 'package:vegeline_vendor/models/vendor_type.dart';
import 'package:vegeline_vendor/services/auth_service.dart';
import 'package:vegeline_vendor/services/db_service.dart';
import 'package:vegeline_vendor/shared/alert_system.dart';
import 'package:vegeline_vendor/shared/constants.dart';
import 'package:vegeline_vendor/shared/dissmiss_keyboard.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

Widget buildFormSubmitButton(
    {@required String text, @required Function onPressed}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: <Widget>[
      RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        padding: EdgeInsets.symmetric(
          vertical: 12.0,
          horizontal: 50.0,
        ),
        onPressed: onPressed,
        child: Text(
          '$text',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 20.0,
          ),
        ),
      ),
      SizedBox(width: 20.0),
    ],
  );
}

class _SignUpState extends State<SignUp> {
  Map<String, dynamic> _vendorInfo = {};

  PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[50],
        elevation: 0.0,
        centerTitle: true,
        title: appBarTitle,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
          color: Colors.black,
          iconSize: 32.0,
        ),
      ),
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            BasicInfoForm(
              formData: _vendorInfo,
              onSubmit: (Map<String, dynamic> basicInfo) {
                setState(() {
                  _vendorInfo = {..._vendorInfo, ...basicInfo};
                });
                _pageController.jumpToPage(1);
              },
            ),
            BusinessNameForm(
              formData: _vendorInfo,
              onSubmit: (Map<String, dynamic> businessNameInfo) {
                setState(() {
                  _vendorInfo = {..._vendorInfo, ...businessNameInfo};
                });
                _pageController.jumpToPage(2);
              },
            ),
            LocationForm(
              formData: _vendorInfo,
              onSubmit: (Map<String, dynamic> locationInfo) {
                setState(() {
                  _vendorInfo = {..._vendorInfo, ...locationInfo};
                });
                _pageController.jumpToPage(3);
              },
            ),
            NINForm(
              formData: _vendorInfo,
              onSubmit: (Map<String, dynamic> ninInfo) {
                setState(() {
                  _vendorInfo = {..._vendorInfo, ...ninInfo};
                });
                _pageController.jumpToPage(4);
              },
            ),
            BusinessDescriptionForm(
              formData: _vendorInfo,
              onSubmit: (Map<String, dynamic> descriptionInfo) {
                setState(() {
                  _vendorInfo = {..._vendorInfo, ...descriptionInfo};
                });
                _pageController.jumpToPage(5);
              },
            ),
            PhotoForm(
              formData: _vendorInfo,
              onSubmit: (Map<String, dynamic> photoInfo) {
                setState(() {
                  _vendorInfo = {..._vendorInfo, ...photoInfo};
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

class BasicInfoForm extends StatefulWidget {
  final Function onSubmit;
  final Map<String, dynamic> formData;

  const BasicInfoForm({Key key, this.onSubmit, this.formData})
      : super(key: key);

  @override
  _BasicInfoFormState createState() => _BasicInfoFormState();
}

class _BasicInfoFormState extends State<BasicInfoForm>
    with DismissKeyboard, AutomaticKeepAliveClientMixin {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _fullName = "";
  String _email = "";
  String _phoneNumber = "";
  String _password = "";

  Function onSubmit;

  @override
  void initState() {
    onSubmit = widget.onSubmit;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      padding: EdgeInsets.all(25.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    'Create your account (1/6)',
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
              initialValue: _fullName,
              onChanged: (val) => setState(() {
                _fullName = val.trim();
              }),
              validator: (val) {
                if (val.trim().isEmpty) return 'Enter your full name';
                return null;
              },
              decoration: textInputDecoration.copyWith(hintText: 'Full Name'),
            ),
            SizedBox(height: 20.0),
            TextFormField(
              initialValue: _email,
              onChanged: (val) => setState(() {
                _email = val.trim();
              }),
              validator: (val) {
                if (val.trim().isEmpty) return 'Enter your email';
                return null;
              },
              decoration: textInputDecoration.copyWith(hintText: 'Email'),
            ),
            SizedBox(height: 20.0),
            TextFormField(
              initialValue: _phoneNumber,
              onChanged: (val) => setState(() {
                _phoneNumber = val.trim();
              }),
              validator: (val) {
                if (val.trim().isEmpty) return 'Enter your phone number';
                return null;
              },
              decoration:
                  textInputDecoration.copyWith(hintText: 'Phone Number'),
            ),
            SizedBox(height: 20.0),
            TextFormField(
              initialValue: _password,
              onChanged: (val) => setState(() {
                _password = val;
              }),
              validator: (val) {
                if (val.isEmpty) return 'Enter password';
                return null;
              },
              decoration: textInputDecoration.copyWith(hintText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 60.0),
            buildFormSubmitButton(
              text: 'Next',
              onPressed: () {
                dismissKeyboard(context);
                if (_formKey.currentState.validate()) {
                  if (onSubmit != null)
                    onSubmit({
                      'fullName': _fullName,
                      'email': _email,
                      'phoneNumber': _phoneNumber,
                      'password': _password,
                    });
                }
              },
            )
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class BusinessNameForm extends StatefulWidget {
  final Function onSubmit;
  final Map<String, dynamic> formData;

  const BusinessNameForm({Key key, this.onSubmit, this.formData})
      : super(key: key);

  @override
  _BusinessNameFormState createState() => _BusinessNameFormState();
}

class _BusinessNameFormState extends State<BusinessNameForm>
    with DismissKeyboard, AutomaticKeepAliveClientMixin {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _businessName = "";
  String _vendorType;

//  List<String> _vendorTypes = [...VendorType.vendorTypeList];

  Function onSubmit;

  @override
  void initState() {
    onSubmit = widget.onSubmit;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      padding: EdgeInsets.all(25.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            SizedBox(height: 10.0),
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    "Every business needs a name (2/6)",
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
              initialValue: _businessName,
              onChanged: (val) => setState(() {
                _businessName = val.trim();
              }),
              validator: (val) {
                if (val.trim().isEmpty) return 'Enter your business name';
                return null;
              },
              decoration:
                  textInputDecoration.copyWith(hintText: 'Business Name'),
            ),
            SizedBox(height: 20.0),
            DropdownButtonFormField(
                hint: Text('Business Type'),
                validator: (val) {
                  if (val == null) return "Choose your business type";
                  return null;
                },
                value: _vendorType,
                onChanged: (val) {
                  setState(() {
                    _vendorType = val;
                  });
                },
                items: [
                  DropdownMenuItem(
                    child: Text('Retail'),
                    value: VendorType.RETAIL,
                  ),
                  DropdownMenuItem(
                    child: Text('Wholesale'),
                    value: VendorType.WHOLE_SALE,
                  ),
                ]),
            SizedBox(height: 60.0),
            buildFormSubmitButton(
              text: 'Next',
              onPressed: () {
                dismissKeyboard(context);
                if (_formKey.currentState.validate()) {
                  if (onSubmit != null)
                    onSubmit({
                      'businessName': _businessName,
                      'vendorType': _vendorType,
                    });
                }
              },
            )
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class LocationForm extends StatefulWidget {
  final Function onSubmit;
  final Map<String, dynamic> formData;

  const LocationForm({Key key, this.onSubmit, this.formData}) : super(key: key);

  @override
  _LocationFormState createState() => _LocationFormState();
}

class _LocationFormState extends State<LocationForm>
    with DismissKeyboard, AutomaticKeepAliveClientMixin {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _location = "";

  Function onSubmit;

  @override
  void initState() {
    onSubmit = widget.onSubmit;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      padding: EdgeInsets.all(25.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            SizedBox(height: 10.0),
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    "Let's get you your market (3/6)",
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
              initialValue: _location,
              onChanged: (val) => setState(() {
                _location = val.trim();
              }),
              validator: (val) {
                if (val.trim().isEmpty) return 'Enter your business location';
                return null;
              },
              decoration: textInputDecoration.copyWith(
                  hintText: 'Business Location e.g Kikuubo'),
            ),
            SizedBox(height: 60.0),
            buildFormSubmitButton(
              text: 'Next',
              onPressed: () {
                dismissKeyboard(context);
                if (_formKey.currentState.validate()) {
                  if (onSubmit != null)
                    onSubmit({
                      'location': _location,
                    });
                }
              },
            )
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class NINForm extends StatefulWidget {
  final Function onSubmit;
  final Map<String, dynamic> formData;

  const NINForm({Key key, this.onSubmit, this.formData}) : super(key: key);

  @override
  _NINFormState createState() => _NINFormState();
}

class _NINFormState extends State<NINForm>
    with DismissKeyboard, AutomaticKeepAliveClientMixin {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _NIN = "";

  Function onSubmit;

  @override
  void initState() {
    onSubmit = widget.onSubmit;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      padding: EdgeInsets.all(25.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            SizedBox(height: 10.0),
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    "For a better experience (4/6)",
                    style: TextStyle(
                      fontSize: 36.0,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 25.0),
            Text(
              "We need your National ID Number to create a secure working environment",
              style: TextStyle(fontSize: 24.0, color: Colors.grey),
            ),
            SizedBox(height: 40.0),
            TextFormField(
              initialValue: _NIN,
              onChanged: (val) => setState(() {
                _NIN = val.trim();
              }),
              validator: (val) {
                if (val.trim().isEmpty) return 'Enter your National ID Number';
                return null;
              },
              decoration: textInputDecoration.copyWith(hintText: 'NIN Number'),
            ),
            SizedBox(height: 60.0),
            buildFormSubmitButton(
              text: 'Next',
              onPressed: () {
                dismissKeyboard(context);
                if (_formKey.currentState.validate()) {
                  if (onSubmit != null) onSubmit({'NIN': _NIN});
                }
              },
            )
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class BusinessDescriptionForm extends StatefulWidget {
  final Function onSubmit;
  final Map<String, dynamic> formData;

  const BusinessDescriptionForm({Key key, this.onSubmit, this.formData})
      : super(key: key);

  @override
  _BusinessDescriptionFormState createState() =>
      _BusinessDescriptionFormState();
}

class _BusinessDescriptionFormState extends State<BusinessDescriptionForm>
    with DismissKeyboard, AutomaticKeepAliveClientMixin {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _description = "";

  Function onSubmit;

  @override
  void initState() {
    onSubmit = widget.onSubmit;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      padding: EdgeInsets.all(25.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            SizedBox(height: 10.0),
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    "Let them know your business (5/6)",
                    style: TextStyle(
                      fontSize: 36.0,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 45.0),
            TextFormField(
              initialValue: _description,
              onChanged: (val) => setState(() {
                _description = val.trim();
              }),
              maxLines: 13,
              style: TextStyle(fontSize: 20.0),
              decoration: textInputDecoration.copyWith(
                contentPadding: EdgeInsets.all(8.0),
                border: OutlineInputBorder(),
                hintText:
                    "Add a brief description of what you do and have accomplished",
              ),
            ),
            SizedBox(height: 60.0),
            buildFormSubmitButton(
              text: _description.isNotEmpty ? 'Next' : 'Skip',
              onPressed: () {
                dismissKeyboard(context);
                if (_formKey.currentState.validate()) {
                  if (onSubmit != null)
                    onSubmit({'businessDescription': _description});
                }
              },
            )
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class PhotoForm extends StatefulWidget {
  final Function onSubmit;
  final Map<String, dynamic> formData;

  const PhotoForm({Key key, this.onSubmit, this.formData}) : super(key: key);

  @override
  _PhotoFormState createState() => _PhotoFormState();
}

class _PhotoFormState extends State<PhotoForm>
    with DismissKeyboard, AutomaticKeepAliveClientMixin, AlertSystemMixin {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  AuthService _auth = AuthService();
  DBService _db = DBService();

  File _image;

  Map<String, dynamic> _formData;
  Function _onSubmit;
  bool _isSigningUp = false;

  void _loadImage() async {
    final i = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = i;
    });
  }

  _doSignUp(Map<String, dynamic> vendorInfo) async {
    setState(() {
      _isSigningUp = true;
    });
    Vendor _vendor = Vendor(
      fullName: vendorInfo['fullName'],
      NIN: vendorInfo['NIN'],
      businessName: vendorInfo['businessName'],
      imageBase64: vendorInfo["imageBase64"], // TODO: set this back to vendorInfo["imageBase64"]
      phoneNumber: vendorInfo['phoneNumber'],
      vendorType: vendorInfo['vendorType'],
      location: vendorInfo['location'],
      businessDescription: vendorInfo['businessDescription'],
    );

    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString("vendor", jsonEncode(_vendor.toJson()));
    await prefs.setBool("vendorSaved", false);

    try{
      await _auth.createUserWithEmailAndPassword(
        email: vendorInfo['email'],
        password: vendorInfo['password'],
      );
      Navigator.pop(context);
    }catch(e){
      prefs.remove("vendor");
      prefs.remove("vendorSaved");
      alertErrorWithContext(context, e.toString());
    }
    setState(() {
      _isSigningUp = false;
    });
  }

  @override
  void initState() {
    _onSubmit = widget.onSubmit;
    _formData = widget.formData;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      padding: EdgeInsets.all(25.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            SizedBox(height: 10.0),
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    "Add your photo and let's get you selling (6/6)",
                    style: TextStyle(
                      fontSize: 36.0,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 45.0),
            Stack(children: [
              CircleAvatar(
                radius: MediaQuery.of(context).size.width / 3.5,
                backgroundImage: _image == null ? null : FileImage(_image),
                child: _image == null
                    ? Icon(
                        Icons.person_outline,
                        size: 72.0,
                      )
                    : null,
              ),
              Positioned(
                bottom: 0.0,
                right: 0.0,
                child: IconButton(
                  icon: Icon(Icons.camera_alt),
                  onPressed: () {
                    _loadImage();
                  },
                  iconSize: 32.0,
                ),
              )
            ]),
            SizedBox(height: 60.0),
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
                    onPressed: _isSigningUp
                        ? null
                        : () async {
                            dismissKeyboard(context);
                            if (_formKey.currentState.validate()) {
                              String imageBase64 = _image == null
                                  ? null
                                  : base64.encode(await _image.readAsBytes());
                              if (_onSubmit != null) {
                                _onSubmit({
                                  'imageBase64': imageBase64,
                                });
                              }
                              _doSignUp({
                                ..._formData,
                                'imageBase64': imageBase64,
                              });
                            }
                          },
                    child: Text(
                      _isSigningUp ? 'Signing Up' : 'Get Started',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

//class SignUpButton extends StatefulWidget with AlertSystemMixin {
//  final Map<String, dynamic> formData;
//  final Function onPressed;
//
//  const SignUpButton({Key key, this.formData, this.onPressed})
//      : super(key: key);
//
//  @override
//  _SignUpButtonState createState() => _SignUpButtonState();
//}
//
//class _SignUpButtonState extends State<SignUpButton> {
//  bool _isSigningUp = false;
//  Map<String, dynamic> _formData;
//  Function _onPressed;
//
//  @override
//  void initState() {
//    _formData = widget.formData;
//    _onPressed = widget.onPressed;
//    super.initState();
//  }
//
//  _doSignUp() async {
//    setState(() {
//      _isSigningUp = true;
//    });
//
//    setState(() {
//      _isSigningUp = false;
//    });
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Column(
//      crossAxisAlignment: CrossAxisAlignment.stretch,
//      children: <Widget>[
//        Container(
//          margin: EdgeInsets.symmetric(horizontal: 15.0),
//          child: RaisedButton(
//            shape: RoundedRectangleBorder(
//              borderRadius: BorderRadius.circular(21.0),
//            ),
//            padding: EdgeInsets.symmetric(vertical: 12.0),
//            onPressed: _isSigningUp
//                ? null
//                : () async {
//                    if (_onPressed != null) {
//                      await _onPressed();
//                    }
//                    await _doSignUp();
//                  },
//            child: Text(
//              _isSigningUp ? 'Signing Up' : 'Get Started',
//              style: TextStyle(
//                fontWeight: FontWeight.w900,
//                fontSize: 20.0,
//              ),
//            ),
//          ),
//        ),
//      ],
//    );
//  }
//}
