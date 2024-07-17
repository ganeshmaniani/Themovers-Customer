import 'package:dartz/dartz.dart';

import '../../../../../core/core.dart';
import '../../../../booking/booking.dart';

class BookingDetailsUseCase {
  final BookingRepository _repository;
  BookingDetailsUseCase(this._repository);

  Future<Either<Failure, BookingDetailsModel>> call(String bookingId) async {
    return await _repository.getBookingDetail(bookingId);
  }
}
