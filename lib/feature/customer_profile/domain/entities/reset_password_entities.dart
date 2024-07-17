import 'package:equatable/equatable.dart';

class ResetPasswordEntities extends Equatable {
  final String customerId;
  final String newPassword;
  final String conformPassword;

  const ResetPasswordEntities(
      {required this.newPassword,
      required this.conformPassword,
      required this.customerId});

  @override
  List<Object?> get props {
    return [newPassword, conformPassword];
  }

  @override
  bool get stringify => true;

  ResetPasswordEntities copyWith(
      {final String? newPassword,
      final String? conformPassword,
      String? customerId}) {
    return ResetPasswordEntities(
      newPassword: newPassword ?? this.newPassword,
      conformPassword: conformPassword ?? this.conformPassword,
      customerId: customerId ?? this.customerId,
    );
  }
}
