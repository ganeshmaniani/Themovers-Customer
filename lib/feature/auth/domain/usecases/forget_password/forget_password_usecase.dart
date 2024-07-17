import 'package:dartz/dartz.dart';

import '../../../../../core/core.dart';
import '../../../auth.dart';

class ForgetPasswordUseCase
    implements UseCase<AuthResult, ForgetPasswordEntities> {
  final AuthRepository _authRepository;

  ForgetPasswordUseCase(this._authRepository);

  @override
  Future<Either<Failure, AuthResult>> call(
      ForgetPasswordEntities forgetPasswordEntities) async {
    return await _authRepository.forgetPassword(forgetPasswordEntities);
  }
}
