import 'package:dartz/dartz.dart';
import 'package:themovers/feature/feature.dart';

import '../../../../../core/core.dart';

class PremiumPlaceUseCase
    implements UseCase<PremiumAutoCompletePredictions, PremiumPlaceEntities> {
  final PremiumRepository _repository;
  PremiumPlaceUseCase(this._repository);

  @override
  Future<Either<Failure, PremiumAutoCompletePredictions>> call(
      PremiumPlaceEntities placeEntities) async {
    return await _repository.placesAutoComplete(placeEntities);
  }
}
