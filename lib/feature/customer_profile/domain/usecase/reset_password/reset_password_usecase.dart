import 'package:dartz/dartz.dart';
import 'package:themovers/core/core.dart';
import 'package:themovers/feature/customer_profile/customer_profile.dart';
import 'package:themovers/feature/customer_profile/domain/entities/reset_password_entities.dart';

class ResetPasswordUseCase implements UseCase<dynamic, ResetPasswordEntities> {
  final CustomerProfileRepository _customerProfileRepository;

  ResetPasswordUseCase(this._customerProfileRepository);

  @override
  Future<Either<Failure, dynamic>> call(
      ResetPasswordEntities resetPasswordEntities) async {
    return await _customerProfileRepository
        .resetPassword(resetPasswordEntities);
  }
}
