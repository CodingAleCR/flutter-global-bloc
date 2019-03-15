import 'dart:async';
import '../validators/validators.dart';
import 'package:rxdart/rxdart.dart';

class Bloc extends Validators {
  final _email = BehaviorSubject<String>();
  Function(String) get changeEmail => _email.sink.add;
  Stream<String> get email => _email.stream.transform(emailValidator);

  final _password = BehaviorSubject<String>();
  Function(String) get changePassword => _password.sink.add;
  Stream<String> get password => _password.stream.transform(passwordValidator);

  Stream<bool> get submitValid => Observable.combineLatest2(
      email, password, (emailString, passwordString) => true);

  submit() {
    String validEmail =_email.value;
    String validPassword = _password.value;

    print('User credentials are: Email=$validEmail and Password=$validPassword');
  }

  dispose() {
    _email.close();
    _password.close();
  }
}

final bloc = Bloc();
