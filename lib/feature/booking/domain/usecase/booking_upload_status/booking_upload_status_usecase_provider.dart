import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../booking.dart';

final bookingUploadStatusUseCaseProvider = Provider<BookingUploadStatusUseCase>((ref) {
  final bookingRepository = ref.watch(bookingRepositoryProvider);
  return BookingUploadStatusUseCase(bookingRepository);
});
