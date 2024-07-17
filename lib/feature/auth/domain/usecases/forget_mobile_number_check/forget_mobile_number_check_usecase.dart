import 'package:dartz/dartz.dart';

import '../../../../../core/core.dart';
import '../../../auth.dart';

class ForgetPasswordMobileNumberCheckUseCase
    implements UseCase<AuthResult, String> {
  final AuthRepository _authRepository;

  ForgetPasswordMobileNumberCheckUseCase(this._authRepository);

  @override
  Future<Either<Failure, AuthResult>> call(String phone) async {
    return await _authRepository.forgetPasswordMobileNumberChecker(phone);
  }
}
