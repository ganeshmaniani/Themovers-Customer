import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/core.dart';
import '../../../booking/booking.dart';

final bookingDatasourceProvider = Provider<BookingDataSource>((ref) {
  final apiServices = ref.watch(serviceProvider);
  return BookingDataSourceImpl(apiServices);
});
