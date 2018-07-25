import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          emailField(),
          passwordField(),
          Container(margin: EdgeInsets.only(top: 25.0),),
          submitBtn(),
        ],
      ),
    );
  }

  Widget emailField() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'me@example.com',
        labelText: 'Email'
      ),
      keyboardType: TextInputType.emailAddress,
    );
  }

  Widget passwordField() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'my_secret',
        labelText: 'Password'
      ),
      obscureText: true,
    );
  }

  Widget submitBtn() {
    return RaisedButton(
      child: Text('Login'),
      color: Colors.blue,
      onPressed: (){},
    );
  }
}