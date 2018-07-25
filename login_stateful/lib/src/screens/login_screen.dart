import 'package:flutter/material.dart';
import '../mixins/validation_mixin.dart';

class LoginScreen extends StatefulWidget {
  State<StatefulWidget> createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> with ValidationMixin {
  final formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';

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
      validator: validateEmail,
      onSaved: (String value) {
        print(value);
        email = value;
      },
    );
  }

  Widget passwordField() {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Password',
        hintText: 'my_secret',
      ),
      validator: validatePassword,
      onSaved: (String value) {
        print(value);
        password = value;
      },
    );
  }

  Widget submitBtn() {
    return RaisedButton(
      child: Text('Login'),
      onPressed: () {
        if(formKey.currentState.validate()) {
          formKey.currentState.save();
          print('POST email $email and password $password to our API');
        }
      },
      color: Colors.blue,
    );
  }

}