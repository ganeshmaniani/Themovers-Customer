import 'package:dartz/dartz.dart';

import '../../../../manpower/manpower.dart';
import '../../../../../core/core.dart';

class ManpowerPlaceUseCase
    implements UseCase<ManpowerAutoCompletePredictions, ManpowerPlaceEntities> {
  final ManpowerRepository _repository;
  ManpowerPlaceUseCase(this._repository);

  @override
  Future<Either<Failure, ManpowerAutoCompletePredictions>> call(
      ManpowerPlaceEntities placeEntities) async {
    return await _repository.placesAutoComplete(placeEntities);
  }
}
