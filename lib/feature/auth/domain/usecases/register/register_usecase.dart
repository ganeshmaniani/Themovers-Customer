import 'package:dartz/dartz.dart';

import '../../../../../core/core.dart';
import '../../../auth.dart';

class RegisterUseCase implements UseCase<AuthResult, RegisterEntities> {
  final AuthRepository _authRepository;

  RegisterUseCase(this._authRepository);

  @override
  Future<Either<Failure, AuthResult>> call(
      RegisterEntities registerEntities) async {
    return await _authRepository.register(registerEntities);
  }
}
