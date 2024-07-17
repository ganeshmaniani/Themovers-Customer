import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../premium/premium.dart';

final premiumRepositoryProvider = Provider<PremiumRepository>((ref) {
  final remoteDataSource = ref.watch(premiumDatasourceProvider);
  return PremiumRepositoryImpl(remoteDataSource);
});
