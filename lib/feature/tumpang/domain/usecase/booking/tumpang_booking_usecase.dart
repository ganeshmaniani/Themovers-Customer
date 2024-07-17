import 'package:dartz/dartz.dart';

import '../../../../../core/core.dart';
import '../../../../tumpang/tumpang.dart';

class TumpangBookingUseCase implements UseCase<dynamic, TumpangEntities> {
  final TumpangRepository _repository;
  TumpangBookingUseCase(this._repository);

  @override
  Future<Either<Failure, dynamic>> call(TumpangEntities tumpangEntities) async {
    return await _repository.tumpangBooking(tumpangEntities);
  }
}
