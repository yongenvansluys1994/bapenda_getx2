// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:equatable/equatable.dart';
import 'package:bapenda_getx2/app/modules/auth/dto/user_model.dart';

class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class UnAuthenticated extends AuthenticationState {
  String message;

  UnAuthenticated(this.message);

  @override
  List<Object> get props => [message];
}

class Authenticated extends AuthenticationState {
  final User user;
  final bool isLoggedIn;

  const Authenticated({required this.user, required this.isLoggedIn});

  @override
  List<Object> get props => [user, isLoggedIn];
}

class AuthenticationFailure extends AuthenticationState {
  final String message;

  const AuthenticationFailure({required this.message});

  @override
  List<Object> get props => [message];
}
