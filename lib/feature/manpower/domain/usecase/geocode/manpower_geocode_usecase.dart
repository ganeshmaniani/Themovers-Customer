import 'package:dartz/dartz.dart';

import '../../../../../core/core.dart';
import '../../../../manpower/manpower.dart';

class ManpowerPlaceToGeocodeUseCase
    implements
        UseCase<ManpowerPlaceToGeocodeModel, ManpowerPlaceToGeocodeEntities> {
  final ManpowerRepository _repository;
  ManpowerPlaceToGeocodeUseCase(this._repository);

  @override
  Future<Either<Failure, ManpowerPlaceToGeocodeModel>> call(
      ManpowerPlaceToGeocodeEntities placeToGeocodeEntities) async {
    return await _repository.placesToGeocode(placeToGeocodeEntities);
  }
}
