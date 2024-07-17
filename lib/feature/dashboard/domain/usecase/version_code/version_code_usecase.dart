import 'package:dartz/dartz.dart';

import '../../../../../core/core.dart';
import '../../../data/data.dart';
import '../../domain.dart';

class VersionCodeUseCase {
  final ImageSliderRepository _repository;

  VersionCodeUseCase(this._repository);

  Future<Either<Failure, VersionModel>> call() async {
    return await _repository.getVersionCode();
  }
}
