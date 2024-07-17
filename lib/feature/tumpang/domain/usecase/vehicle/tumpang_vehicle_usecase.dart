import 'package:dartz/dartz.dart';

import '../../../../../core/core.dart';
import '../../../tumpang.dart';

class TumpangVehicleTypeUseCase {
  final TumpangRepository _repository;
  TumpangVehicleTypeUseCase(this._repository);

  Future<Either<Failure, dynamic>> call() async {
    return await _repository.getVehicleType();
  }
}
