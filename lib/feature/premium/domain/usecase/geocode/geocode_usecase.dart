import 'package:dartz/dartz.dart';

import '../../../../../core/core.dart';
import '../../../../premium/premium.dart';

class PremiumPlaceToGeocodeUseCase
    implements
        UseCase<PremiumPlaceToGeocodeModel, PremiumPlaceToGeocodeEntities> {
  final PremiumRepository _repository;
  PremiumPlaceToGeocodeUseCase(this._repository);

  @override
  Future<Either<Failure, PremiumPlaceToGeocodeModel>> call(
      PremiumPlaceToGeocodeEntities placeToGeocodeEntities) async {
    return await _repository.placesToGeocode(placeToGeocodeEntities);
  }
}
