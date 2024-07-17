import 'package:dartz/dartz.dart';

import '../../../../../core/core.dart';
import '../../../disposal.dart';

class DisposalBookingUseCase implements UseCase<dynamic, DisposalEntities> {
  final DisposalRepository _repository;
  DisposalBookingUseCase(this._repository);

  @override
  Future<Either<Failure, dynamic>> call(DisposalEntities budgetEntities) async {
    return await _repository.disposalBooking(budgetEntities);
  }
}
