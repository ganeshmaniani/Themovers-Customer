import 'package:dartz/dartz.dart';

import '../../../../../core/core.dart';
import '../../../../disposal/disposal.dart';

class DisposalPlaceUseCase
    implements UseCase<DisposalAutoCompletePredictions, DisposalPlaceEntities> {
  final DisposalRepository _repository;
  DisposalPlaceUseCase(this._repository);

  @override
  Future<Either<Failure, DisposalAutoCompletePredictions>> call(
      DisposalPlaceEntities placeEntities) async {
    return await _repository.placesAutoComplete(placeEntities);
  }
}
