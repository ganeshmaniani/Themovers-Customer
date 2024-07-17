import 'package:dartz/dartz.dart';

import '../../../../../core/core.dart';
import '../../../../disposal/disposal.dart';

class DisposalVehicleTypeUseCase {
  final DisposalRepository _repository;
  DisposalVehicleTypeUseCase(this._repository);

  Future<Either<Failure, dynamic>> call() async {
    return await _repository.getVehicleType();
  }
}
