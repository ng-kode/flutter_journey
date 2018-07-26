import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'validators.dart';

class Bloc extends Object with Validators {
  final _emailCrtl = BehaviorSubject<String>();
  final _passwordCrtl = BehaviorSubject<String>();

  // Access to stream
  Stream<String> get email => _emailCrtl
    .stream
    .transform(validateEmail);
  Stream<String> get password => _passwordCrtl
    .stream
    .transform(validatePassword);
  Stream<bool> get submitValid => Observable
    .combineLatest2(email, password, (eData, pData) => true);

  // Add data to stream
  Function(String) get changeEmail => _emailCrtl.sink.add;
  Function(String) get changePassword => _passwordCrtl.sink.add;

  dispose() {
    _emailCrtl.close();
    _passwordCrtl.close();
  }

  submit() {
    final validEmail = _emailCrtl.value;
    final validPassword = _passwordCrtl.value;

    print('validEmail is $validEmail');
    print('validPassword is $validPassword');
  }
}
