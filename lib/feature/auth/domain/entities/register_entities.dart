import 'package:equatable/equatable.dart';

class RegisterEntities extends Equatable {
  final String name;
  final String email;
  final String number;
  final String password;
  const RegisterEntities(
      {required this.name,
      required this.email,
      required this.number,
      required this.password});

  @override
  List<Object> get props {
    return [name, email, number, password];
  }

  @override
  bool get stringify => true;

  RegisterEntities copyWith({
    final String? name,
    final String? email,
    final String? number,
    final String? password,
  }) {
    return RegisterEntities(
      name: name ?? this.name,
      email: email ?? this.email,
      number: number ?? this.number,
      password: password ?? this.password,
    );
  }
}
