import 'package:dartz/dartz.dart';

import '../../../../../core/core.dart';
import '../../../auth.dart';

class PhoneNoUseCase implements UseCase<AuthResult, String> {
  final AuthRepository _authRepository;

  PhoneNoUseCase(this._authRepository);

  @override
  Future<Either<Failure, AuthResult>> call(String phone) async {
    return await _authRepository.phoneNoChecker(phone);
  }
}
