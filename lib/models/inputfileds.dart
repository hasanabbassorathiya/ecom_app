import 'package:flutter/material.dart';

class inputFileds extends StatelessWidget {
  String title, labelText;
  Function function;
  IconButton suffixicon;
  IconButton prefixicon;
  Function onEditingComplete;
  TextEditingController Controller;
  bool isPassword;

  TextInputType textInputType;

  inputFileds({
    this.title,
    this.labelText,
    this.suffixicon,
    this.prefixicon,
    this.function,
    this.Controller,
    this.isPassword,
    this.textInputType,
    this.onEditingComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 15, left: 20, right: 20),
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
              color: Colors.grey,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            obscureText: isPassword,
            controller: Controller,
            onEditingComplete: onEditingComplete,
            keyboardType: textInputType,
            decoration: InputDecoration(

//                labelText: labelText,
                suffixIcon: suffixicon,
                prefixIcon: prefixicon,
                labelStyle: TextStyle(),
                border: InputBorder.none,
                fillColor: Color(0xfff3f3f4),
                filled: true),
            onChanged: function,
          )
        ],
      ),
    );
  }
}
