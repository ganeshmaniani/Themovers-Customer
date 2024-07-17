import 'package:dartz/dartz.dart';
import 'package:themovers/core/core.dart';
import 'package:themovers/feature/auth/auth.dart';

class EmailOtpGeneratorUseCase implements UseCase<AuthResult, String> {
  final AuthRepository _authRepository;

  EmailOtpGeneratorUseCase(this._authRepository);

  @override
  Future<Either<Failure, AuthResult>> call(String email) async {
    return await _authRepository.emailOtpGenerator(email);
  }

}