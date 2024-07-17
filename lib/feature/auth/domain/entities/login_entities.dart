import 'package:equatable/equatable.dart';

class LoginEntities extends Equatable {
  final String userId;
  final String password;
  const LoginEntities({required this.userId, required this.password});

  @override
  List<Object> get props {
    return [userId, password];
  }

  @override
  bool get stringify => true;

  LoginEntities copyWith({
    final String? userId,
    final String? password,
  }) {
    return LoginEntities(
      userId: userId ?? this.userId,
      password: password ?? this.password,
    );
  }
}
