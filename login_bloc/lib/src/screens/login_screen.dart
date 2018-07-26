import 'package:flutter/material.dart';
import '../blocs/bloc.dart';

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
    return StreamBuilder(
      stream: bloc.email,
      builder: (context, snapshot) {
        return TextField(
          onChanged: bloc.changeEmail,
          decoration: InputDecoration(
            hintText: 'me@example.com',
            labelText: 'Email',
            errorText: snapshot.error,
          ),
          keyboardType: TextInputType.emailAddress,
        );
      },
    );
  }

  Widget passwordField() {
    return StreamBuilder(
      stream: bloc.password,
      builder: (context, snapshot) {
        return TextField(
          onChanged: bloc.changePassword,
          decoration: InputDecoration(
            hintText: 'my_secret',
            labelText: 'Password',
            errorText: snapshot.error,
          ),
          obscureText: true,
        );
      },
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