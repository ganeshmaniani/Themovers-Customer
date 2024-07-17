import 'package:dartz/dartz.dart';

import '../../../../../core/core.dart';
import '../../../../premium/premium.dart';

class PremiumBookingUseCase implements UseCase<dynamic, PremiumEntities> {
  final PremiumRepository _repository;
  PremiumBookingUseCase(this._repository);

  @override
  Future<Either<Failure, dynamic>> call(PremiumEntities premiumEntities) async {
    return await _repository.premiumBooking(premiumEntities);
  }
}
