import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/usecases/usecases.dart';
import '../../../data/model/auth_result.dart';
import '../../repositories/auth_repository.dart';

class ValidEmailCheckerUseCase implements UseCase<AuthResult, String> {
  final AuthRepository _authRepository;

  ValidEmailCheckerUseCase(this._authRepository);

  @override
  Future<Either<Failure, AuthResult>> call(String email) async {
    return await _authRepository.validEmailChecker(email);
  }
}
