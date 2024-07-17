import 'package:dartz/dartz.dart';

import '../../../../../core/core.dart';
import '../../../../premium/premium.dart';

class PremiumLongPushTypeUseCase {
  final PremiumRepository _repository;
  PremiumLongPushTypeUseCase(this._repository);

  Future<Either<Failure, PremiumLongpushTypeModel>> call() async {
    return await _repository.getLongPushTypeList();
  }
}
