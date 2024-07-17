import 'package:dartz/dartz.dart';
import 'package:themovers/core/core.dart';
import 'package:themovers/feature/customer_profile/customer_profile.dart';

class CustomerProfileImageUpdateUseCase
    implements UseCase<dynamic, CustomerProfileImageUpdateEntities> {
  final CustomerProfileRepository _repository;

  CustomerProfileImageUpdateUseCase(this._repository);

  @override
  Future<Either<Failure, dynamic>> call(
      CustomerProfileImageUpdateEntities
          customerProfileImageUpdateEntities) async {
    return await _repository
        .customerProfileImageUpdate(customerProfileImageUpdateEntities);
  }
}
