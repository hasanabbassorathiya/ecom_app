import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'file:///F:/flutter_demo/ecom_app/lib/models/submit_button.dart';
import 'file:///F:/flutter_demo/ecom_app/lib/screens/product_screen.dart';

import '../models/inputfileds.dart';

class StudentLogin extends StatefulWidget {
  @override
  _StudentLoginState createState() => _StudentLoginState();
}

class _StudentLoginState extends State<StudentLogin> {
  bool checkValue = false;
  bool loading;

  final login_email = TextEditingController();
  final login_pass = TextEditingController();
  bool passwordVisibility = false;

  bool wrong_email = false;

  void check() {
    setState(() {
      var emailValid = RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
          .hasMatch(login_email.text);
      wrong_email = emailValid;
      print(emailValid);
    });
  }

  @override
  void initState() {
    setState(() {
      loading = false;
    });
    super.initState();
  }

  @override
  void dispose() {
    login_pass.dispose();
    login_email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          inputFileds(
            title: 'Email',
            textInputType: TextInputType.emailAddress,
            Controller: login_email,
            isPassword: false,
            onEditingComplete: check,
            prefixicon: IconButton(
              icon: Icon(
                Icons.account_circle,
                color: wrong_email ? Colors.green : Colors.red,
              ),
            ),
          ),
          inputFileds(
            title: 'Password',
            textInputType: TextInputType.visiblePassword,
            Controller: login_pass,
            isPassword: !passwordVisibility,
            prefixicon: IconButton(
                icon: Icon(
                    passwordVisibility ? Icons.lock_open : Icons.lock_outline),
                onPressed: () {
                  setState(() {
                    passwordVisibility = !passwordVisibility;
                  });
                }),
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
            child: Text(
              'Forgot Password!',
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Gilroy',
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          submitButton(
            title: 'Login',
            function: () {
              _navigator();
            },
          )
        ],
      ),
    );
  }

  _navigator() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (login_email.text.length != 0 || login_pass.text.length != 0) {
      setState(() {
        loading = true;
      });

      loading = false;
      prefs.setString('email', login_email.text);
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext ctx) => ProductPage()));
    } else {
      setState(() {
        loading = false;
      });
      showDialog(
          context: context,
          barrierDismissible: false,
          child: new CupertinoAlertDialog(
            content: new Text(
              "staff_email or staff_pass \ncan't be empty",
              style: new TextStyle(fontSize: 16.0),
            ),
            actions: <Widget>[
              new FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: new Text("OK"))
            ],
          ));
    }
  }
}
