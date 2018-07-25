import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  State<StatefulWidget> createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20.0),
      child: Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            emailField(),
            passwordField(),
            Container(margin: EdgeInsets.only(top: 25.0),),
            submitBtn(),
          ],
        ),
      )
    );
  }

  Widget emailField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'me@example.com',
      ),
      keyboardType: TextInputType.emailAddress,
      validator: (String value) {
        // return null if valid
        // return string (error msg) if invalid
        if (!value.contains('@')) {
          return 'Please provide a valid email';
        }
      },
    );
  }

  Widget passwordField() {
    return TextFormField(
      obscureText: false,
      decoration: InputDecoration(
        labelText: 'Password',
        hintText: 'my_secret',
      ),
      validator: (String value) {
        if (value.length < 4) {
          return 'Password must be at least 4 characters';
        }
      },
    );
  }

  Widget submitBtn() {
    return RaisedButton(
      child: Text('Login'),
      onPressed: () {
        print(formKey.currentState.validate());
      },
      color: Colors.blue,
    );
  }

}