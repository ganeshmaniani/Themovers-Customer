import 'package:dartz/dartz.dart';
import 'package:themovers/core/errors/failure.dart';

import '../../../booking/booking.dart';

class BookingRepositoryImpl implements BookingRepository {
  final BookingDataSource _bookingDataSource;

  BookingRepositoryImpl(this._bookingDataSource);

  @override
  Future<Either<Failure, BookingListModel>> getBookingList(
      String customerId) async {
    return _bookingDataSource.getBookingList(customerId);
  }

  @override
  Future<Either<Failure, BookingDetailsModel>> getBookingDetail(
      String bookingId) async {
    return await _bookingDataSource.getBookingDetail(bookingId);
  }

  @override
  Future<Either<Failure, UnAssignedBookingListModel>> getUnAssignedBookingList(
      UnAssignedBookingEntities unAssignedBookingEntities) async {
    return await _bookingDataSource
        .getUnAssignedBookingList(unAssignedBookingEntities);
  }

  @override
  Future<Either<Failure, dynamic>> uploadBookingCompletedStatus(
      StatusUpdateEntities statusUpdateEntities) async {
    return await _bookingDataSource
        .uploadBookingCompletedStatus(statusUpdateEntities);
  }

  @override
  Future<Either<Failure, dynamic>> uploadRating(
      RatingEntities ratingEntities) async {
    return await _bookingDataSource.uploadRating(ratingEntities);
  }
}
