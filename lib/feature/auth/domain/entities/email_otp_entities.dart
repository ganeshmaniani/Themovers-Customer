import 'package:equatable/equatable.dart';

class EmailOtpCheckerEntities extends Equatable {
  final String email;
  final String otp;

  const EmailOtpCheckerEntities({required this.email, required this.otp});

  @override
  List<Object> get props {
    return [email, otp];
  }

  @override
  bool get stringify => true;

  EmailOtpCheckerEntities copyWith({
    final String? email,
    final String? otp,
  }) {
    return EmailOtpCheckerEntities(
      email: email ?? this.email,
      otp: otp ?? this.otp,
    );
  }
}
