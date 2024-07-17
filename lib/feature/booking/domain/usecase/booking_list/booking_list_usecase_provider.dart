import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../booking.dart';

final bookingListUseCaseProvider = Provider<BookingListUseCase>((ref) {
  final authRepository = ref.watch(bookingRepositoryProvider);
  return BookingListUseCase(authRepository);
});
