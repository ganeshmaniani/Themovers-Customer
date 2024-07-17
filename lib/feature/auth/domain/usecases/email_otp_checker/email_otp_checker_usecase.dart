import 'package:dartz/dartz.dart';

import '../../../../../core/core.dart';
import '../../../auth.dart';

class EmailOtpCheckerUseCase
    implements UseCase<AuthResult, EmailOtpCheckerEntities> {
  final AuthRepository _authRepository;

  EmailOtpCheckerUseCase(this._authRepository);

  @override
  Future<Either<Failure, AuthResult>> call(
      EmailOtpCheckerEntities emailOtpCheckerEntities) async {
    return await _authRepository.emailOtpChecker(emailOtpCheckerEntities);
  }
}
