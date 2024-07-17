import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:themovers/feature/booking/booking.dart';
import 'package:themovers/feature/booking/domain/usecase/booking_rating/booking_rating.dart';

final bookingRatingUseCaseProvider = Provider<BookingRatingUseCase>((ref) {
  final bookingRepository = ref.watch(bookingRepositoryProvider);
  return BookingRatingUseCase(bookingRepository);
});
