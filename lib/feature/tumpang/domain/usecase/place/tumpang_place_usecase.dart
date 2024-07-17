import 'package:dartz/dartz.dart';

import '../../../../../core/core.dart';
import '../../../../tumpang/tumpang.dart';

class TumpangPlaceUseCase
    implements UseCase<TumpangAutoCompletePredictions, TumpangPlaceEntities> {
  final TumpangRepository _repository;
  TumpangPlaceUseCase(this._repository);

  @override
  Future<Either<Failure, TumpangAutoCompletePredictions>> call(
      TumpangPlaceEntities placeEntities) async {
    return await _repository.placesAutoComplete(placeEntities);
  }
}
