import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../../../booking/booking.dart';

abstract class BookingDataSource {
  Future<Either<Failure, BookingListModel>> getBookingList(String customerId);

  Future<Either<Failure, BookingDetailsModel>> getBookingDetail(
      String bookingId);

  Future<Either<Failure, UnAssignedBookingListModel>> getUnAssignedBookingList(
      UnAssignedBookingEntities unAssignedBookingEntities);

  Future<Either<Failure, dynamic>> uploadBookingCompletedStatus(
      StatusUpdateEntities statusUpdateEntities);

  Future<Either<Failure, dynamic>> uploadRating(RatingEntities ratingEntities);
}
