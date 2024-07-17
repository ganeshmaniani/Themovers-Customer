import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../booking/booking.dart';

final bookingRepositoryProvider = Provider<BookingRepository>((ref) {
  final remoteDataSource = ref.watch(bookingDatasourceProvider);
  return BookingRepositoryImpl(remoteDataSource);
});
