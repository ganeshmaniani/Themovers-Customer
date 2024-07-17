import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/core.dart';
import '../../premium.dart';

final premiumDatasourceProvider = Provider<PremiumDataSource>((ref) {
  final apiServices = ref.watch(serviceProvider);
  return PremiumDataSourceImpl(apiServices);
});
