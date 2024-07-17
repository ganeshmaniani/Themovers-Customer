import 'package:dartz/dartz.dart';

import '../../../../../core/core.dart';
import '../../../disposal.dart';

class DisposalPlaceToGeocodeUseCase
    implements
        UseCase<DisposalPlaceToGeocodeModel, DisposalPlaceToGeocodeEntities> {
  final DisposalRepository _repository;
  DisposalPlaceToGeocodeUseCase(this._repository);

  @override
  Future<Either<Failure, DisposalPlaceToGeocodeModel>> call(
      DisposalPlaceToGeocodeEntities placeToGeocodeEntities) async {
    return await _repository.placesToGeocode(placeToGeocodeEntities);
  }
}
