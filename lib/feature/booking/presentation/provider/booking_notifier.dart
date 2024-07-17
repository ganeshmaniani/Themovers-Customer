import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/core.dart';
import '../../../booking/booking.dart';
import '../../domain/usecase/booking_rating/booking_rating_usecase.dart';

class BookingListNotifier extends StateNotifier<BookingState> {
  final BookingListUseCase _bookingListUseCase;
  final BookingDetailsUseCase _bookingDetailsUseCase;
  final UnAssignedBookingListUseCase _unAssignedBookingListUseCase;
  final BookingUploadStatusUseCase _bookingUploadStatusUseCase;
  final BookingRatingUseCase _bookingRatingUseCase;

  BookingListNotifier(this._bookingListUseCase, this._bookingDetailsUseCase,
      this._unAssignedBookingListUseCase, this._bookingUploadStatusUseCase,
      this._bookingRatingUseCase)
      : super(const BookingState.initial());

  Future<Either<Failure, BookingListModel>> getBookingList(
      String customerId) async {
    state.copyWith(isLoading: true);
    final result = await _bookingListUseCase(customerId);
    state.copyWith(isLoading: false);
    return result;
  }

  Future<Either<Failure, BookingDetailsModel>> getBookingDetails(
      String bookingId) async {
    state.copyWith(isLoading: true);
    final result = await _bookingDetailsUseCase(bookingId);
    state.copyWith(isLoading: false);
    return result;
  }

  Future<Either<Failure, UnAssignedBookingListModel>> getUnAssignedBookingList(
      UnAssignedBookingEntities unAssignedBookingEntities) async {
    state.copyWith(isLoading: true);
    final result =
    await _unAssignedBookingListUseCase(unAssignedBookingEntities);
    state.copyWith(isLoading: false);
    return result;
  }

  Future<Either<Failure, dynamic>> updateBookingUpdate(
      StatusUpdateEntities statusUpdateEntities) async {
    state.copyWith(isLoading: true);
    final result =
    await _bookingUploadStatusUseCase(statusUpdateEntities);
    state.copyWith(isLoading: false);
    return result;
  }

  Future<Either<Failure, dynamic>> uploadBookingRating(
      RatingEntities ratingEntities) async {
    state.copyWith(isLoading: true);
    final result = await _bookingRatingUseCase(ratingEntities);
    state.copyWith(isLoading: false);
    return result;
  }
}
