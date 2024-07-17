import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:themovers/feature/customer_profile/data/source/customer_profile_datasource_provider.dart';

import '../../../feature.dart';

final customerProfileRepositoryProvider =
    Provider<CustomerProfileRepository>((ref) {
  final remoteDataSource = ref.watch(customerProfileDataSourceProvider);
  return CustomerProfileRepositoryImpl(remoteDataSource);
});
