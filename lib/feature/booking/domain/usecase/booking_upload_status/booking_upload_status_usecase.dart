

import 'package:dartz/dartz.dart';

import '../../../../../core/core.dart';
import '../../../booking.dart';

class BookingUploadStatusUseCase implements UseCase<dynamic, StatusUpdateEntities> {
  final BookingRepository _repository;
  BookingUploadStatusUseCase(this._repository);
  @override
  Future<Either<Failure, dynamic>> call(StatusUpdateEntities statusUpdateEntities ) async {
    return await _repository.uploadBookingCompletedStatus(statusUpdateEntities);
  }
}
