import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'validators.dart';

class Bloc extends Object with Validators {
  final _emailCrtl = StreamController<String>.broadcast();
  final _passwordCrtl = StreamController<String>.broadcast();

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
    
  }
}
