import 'package:dartz/dartz.dart';

import '../../../../../core/core.dart';
import '../../../../booking/booking.dart';

class UnAssignedBookingListUseCase
    implements UseCase<UnAssignedBookingListModel, UnAssignedBookingEntities> {
  final BookingRepository _repository;
  UnAssignedBookingListUseCase(this._repository);

  @override
  Future<Either<Failure, UnAssignedBookingListModel>> call(
      UnAssignedBookingEntities unAssignedBookingEntities) async {
    return await _repository
        .getUnAssignedBookingList(unAssignedBookingEntities);
  }
}
