import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:themovers/core/core.dart';
import 'package:themovers/feature/customer_profile/customer_profile.dart';

final customerProfileDataSourceProvider =
    Provider<CustomerProfileDataSource>((ref) {
  final apiService = ref.watch(serviceProvider);
  return CustomerProfileDataSourceImpl(apiService);
});
