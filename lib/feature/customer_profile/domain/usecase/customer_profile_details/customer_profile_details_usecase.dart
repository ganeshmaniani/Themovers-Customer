import 'package:dartz/dartz.dart';
import 'package:themovers/feature/customer_profile/customer_profile.dart';

import '../../../../../core/errors/failure.dart';

class CustomerProfileDetailUseCase {
  final CustomerProfileRepository _repository;

  CustomerProfileDetailUseCase(this._repository);

  Future<Either<Failure, CustomerProfileDetailModel>> call() async {
    return await _repository.getCustomerProfile();
  }
}
