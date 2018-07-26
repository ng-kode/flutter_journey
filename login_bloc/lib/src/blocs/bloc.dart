import 'dart:async';
import 'validators.dart';

class Bloc extends Object with Validators {
  final _emailCrtl = StreamController<String>();
  final _passwordCrtl = StreamController<String>();

  // Access to stream
  Stream<String> get email => _emailCrtl
    .stream
    .transform(validateEmail);
  Stream<String> get password => _passwordCrtl
    .stream
    .transform(validatePassword);

  // Add data to stream
  Function(String) get changeEmail => _emailCrtl.sink.add;
  Function(String) get changePassword => _passwordCrtl.sink.add;

  dispose() {
    _emailCrtl.close();
    _passwordCrtl.close();
  }
}

final bloc = Bloc();