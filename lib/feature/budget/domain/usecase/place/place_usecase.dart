import 'package:dartz/dartz.dart';

import '../../../../../core/core.dart';
import '../../../budget.dart';

class PlaceUseCase implements UseCase<AutoCompletePrediction, PlaceEntities> {
  final BudgetRepository _repository;
  PlaceUseCase(this._repository);

  @override
  Future<Either<Failure, AutoCompletePrediction>> call(
      PlaceEntities placeEntities) async {
    return await _repository.placesAutoComplete(placeEntities);
  }
}
