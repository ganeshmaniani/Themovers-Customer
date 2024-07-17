import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../booking.dart';

final unAssignedBookingListUseCaseProvider =
    Provider<UnAssignedBookingListUseCase>((ref) {
  final authRepository = ref.watch(bookingRepositoryProvider);
  return UnAssignedBookingListUseCase(authRepository);
});
