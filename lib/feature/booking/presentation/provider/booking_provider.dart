import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:themovers/feature/booking/domain/usecase/booking_rating/booking_rating.dart';

import '../../../booking/booking.dart';

final bookingProvider =
    StateNotifierProvider<BookingListNotifier, BookingState>((ref) {
  final useCaseBookingList = ref.watch(bookingListUseCaseProvider);
  final useCaseBookingDetails = ref.watch(bookingDetailsUseCaseProvider);
  final useCaseUnAssignedBookingDetails =
      ref.watch(unAssignedBookingListUseCaseProvider);
  final useCaseBookingUploadStatus =
      ref.watch(bookingUploadStatusUseCaseProvider);
  final useCaseBookingRating = ref.watch(bookingRatingUseCaseProvider);
  return BookingListNotifier(
      useCaseBookingList,
      useCaseBookingDetails,
      useCaseUnAssignedBookingDetails,
      useCaseBookingUploadStatus,
      useCaseBookingRating);
});
