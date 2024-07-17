import 'package:dartz/dartz.dart';

import '../../../../../core/core.dart';
import '../../../../premium/premium.dart';

class PremiumPackageUseCase {
  final PremiumRepository _repository;
  PremiumPackageUseCase(this._repository);

  Future<Either<Failure, PremiumPackageModel>> call() async {
    return await _repository.getPremiumPackageList();
  }
}
