import 'package:dartz/dartz.dart';

import '../../../../../core/core.dart';
import '../../../auth.dart';

class EmailUseCase implements UseCase<AuthResult, String> {
  final AuthRepository _authRepository;

  EmailUseCase(this._authRepository);

  @override
  Future<Either<Failure, AuthResult>> call(String email) async {
    return await _authRepository.emailChecker(email);
  }
}
