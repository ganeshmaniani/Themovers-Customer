import 'package:dartz/dartz.dart';

import '../../../../../core/core.dart';
import '../../../auth.dart';

class SignInUseCase implements UseCase<AuthResult, LoginEntities> {
  final AuthRepository _authRepository;

  SignInUseCase(this._authRepository);

  @override
  Future<Either<Failure, AuthResult>> call(LoginEntities loginEntities) async {
    return await _authRepository.signIn(loginEntities);
  }
}
