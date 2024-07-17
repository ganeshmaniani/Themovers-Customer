import 'package:dartz/dartz.dart';
import 'package:themovers/core/core.dart';
import 'package:themovers/feature/customer_profile/customer_profile.dart';
import 'package:themovers/feature/customer_profile/domain/entities/customer_delete_account.dart';

class CustomerDeleteAccountUseCase
    implements UseCase<dynamic, CustomerDeleteAccountEntities> {
  final CustomerProfileRepository _repository;

  CustomerDeleteAccountUseCase(this._repository);

  @override
  Future<Either<Failure, dynamic>> call(
      CustomerDeleteAccountEntities customerDeleteAccountEntities) async {
    return await _repository
        .customerDeleteAccount(customerDeleteAccountEntities);
  }
}
