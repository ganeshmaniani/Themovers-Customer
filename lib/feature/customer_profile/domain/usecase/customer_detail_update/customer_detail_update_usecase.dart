import 'package:dartz/dartz.dart';
import 'package:themovers/core/core.dart';
import 'package:themovers/feature/customer_profile/customer_profile.dart';

class CustomerDetailUpdateUseCase
    implements UseCase<dynamic, CustomerDetailUpdateEntities> {
  final CustomerProfileRepository _repository;

  CustomerDetailUpdateUseCase(this._repository);

  @override
  Future<Either<Failure, dynamic>> call(
      CustomerDetailUpdateEntities customerDetailUpdateEntities) async {
    return await _repository.customerDetailUpdate(customerDetailUpdateEntities);
  }
}
