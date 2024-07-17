import 'package:dartz/dartz.dart';

import '../../../../../core/core.dart';
import '../../../../budget/budget.dart';

class PlaceToGeocodeUseCase
    implements UseCase<PlaceToGeocodeModel, PlaceToGeocodeEntities> {
  final BudgetRepository _repository;
  PlaceToGeocodeUseCase(this._repository);

  @override
  Future<Either<Failure, PlaceToGeocodeModel>> call(
      PlaceToGeocodeEntities placeToGeocodeEntities) async {
    return await _repository.placesToGeocode(placeToGeocodeEntities);
  }
}
