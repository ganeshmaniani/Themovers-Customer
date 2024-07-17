import 'package:dartz/dartz.dart';

import '../../../../../core/core.dart';
import '../../../../booking/booking.dart';

class BookingListUseCase {
  final BookingRepository _repository;
  BookingListUseCase(this._repository);

  Future<Either<Failure, BookingListModel>> call(String customerId) async {
    return await _repository.getBookingList(customerId);
  }
}
