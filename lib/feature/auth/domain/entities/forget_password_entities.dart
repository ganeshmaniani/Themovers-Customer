import 'package:equatable/equatable.dart';

class ForgetPasswordEntities extends Equatable {
  final String email;
  final String password;

  const ForgetPasswordEntities({required this.email, required this.password});

  @override
  List<Object> get props {
    return [email, password];
  }

  @override
  bool get stringify => true;

  ForgetPasswordEntities copyWith(
      {final String? email, final String? password}) {
    return ForgetPasswordEntities(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}
