import 'package:dartz/dartz.dart';

import '../../../../../core/core.dart';
import '../../../../tumpang/tumpang.dart';

class TumpangPlaceToGeocodeUseCase
    implements
        UseCase<TumpangPlaceToGeocodeModel, TumpangPlaceToGeocodeEntities> {
  final TumpangRepository _repository;
  TumpangPlaceToGeocodeUseCase(this._repository);

  @override
  Future<Either<Failure, TumpangPlaceToGeocodeModel>> call(
      TumpangPlaceToGeocodeEntities placeToGeocodeEntities) async {
    return await _repository.placesToGeocode(placeToGeocodeEntities);
  }
}
