import 'package:ecomapp/screens/product_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'file:///F:/flutter_demo/ecom_app/lib/models/inputfileds.dart';
import 'file:///F:/flutter_demo/ecom_app/lib/models/submit_button.dart';

class StaffLogin extends StatefulWidget {
  @override
  _StaffLoginState createState() => _StaffLoginState();
}

class _StaffLoginState extends State<StaffLogin> {
  bool checkValue = false;
  bool loading;

  final staff_username = TextEditingController();
  final staff_email = TextEditingController();
  final staff_pass = TextEditingController();
  bool staff_passVisibility = false;

  @override
  void dispose() {
    staff_username.dispose();
    staff_email.dispose();
    staff_pass.dispose();
    setState(() {
      loading = false;
    });
    super.dispose();
  }

  bool wrong_email = false;

  void check() {
    setState(() {
      var emailValid = RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
          .hasMatch(staff_email.text);
      wrong_email = emailValid;
      print(emailValid);
    });
  }

  @override
  void initState() {
    loading = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            inputFileds(
              title: 'Username',
              prefixicon: IconButton(
                icon: Icon(
                  Icons.supervised_user_circle,
                ),
              ),
              Controller: staff_username,
              isPassword: false,
            ),
            inputFileds(
              title: 'Email address',
              onEditingComplete: check,
              prefixicon: IconButton(
                icon: Icon(
                  Icons.account_circle,
                  color: wrong_email ? Colors.green : Colors.red,
                ),
              ),
              Controller: staff_email,
              isPassword: false,
            ),
            inputFileds(
              title: 'Password',
              Controller: staff_pass,
              isPassword: !staff_passVisibility,
              prefixicon: IconButton(
                  icon: Icon(staff_passVisibility
                      ? Icons.lock_open
                      : Icons.lock_outline),
                  onPressed: () {
                    setState(() {
                      staff_passVisibility = !staff_passVisibility;
                    });
                  }),
            ),
            submitButton(
              title: 'SignUp',
              function: () {
                print('Username:${staff_username.text}');
                print('Email:${staff_email.text}');
                print('Password:${staff_pass.text}');

                _navigator();
                print('Signup Button is pressed');
              },
            )
          ],
        ),
      ),
    );
  }

  _navigator() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (staff_email.text.length != 0 || staff_pass.text.length != 0) {
      setState(() {
        loading = true;
      });

      loading = false;
      prefs.setString('email', staff_email.text);
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
