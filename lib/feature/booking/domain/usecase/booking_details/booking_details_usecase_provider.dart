import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../booking.dart';

final bookingDetailsUseCaseProvider = Provider<BookingDetailsUseCase>((ref) {
  final authRepository = ref.watch(bookingRepositoryProvider);
  return BookingDetailsUseCase(authRepository);
});
