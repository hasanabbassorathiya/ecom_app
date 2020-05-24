import 'package:ecomapp/screens/staff_login.dart';
import 'package:ecomapp/screens/student_login.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  bool loading;
  TabController _controller;

  @override
  void initState() {
    _controller = new TabController(length: 2, vsync: this);
    loading = false;
    super.initState();
  }

  check() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
              child: Image.asset(
            'assets/images/welcome.jpg',
            width: MediaQuery.of(context).size.width,
          )),
          Container(
            padding: EdgeInsets.all(20),
            child: TabBar(
                unselectedLabelColor: Colors.green,
                indicatorSize: TabBarIndicatorSize.label,
                controller: _controller,
                indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.green),
                tabs: [
                  Tab(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(color: Colors.green, width: 1)),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Student Login",
                        ),
                      ),
                    ),
                  ),
                  Tab(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(color: Colors.green, width: 1)),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text("Staff Login"),
                      ),
                    ),
                  ),
                ]),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10),
              child: TabBarView(
                controller: _controller,
                children: <Widget>[
                  StudentLogin(),
                  StaffLogin(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
