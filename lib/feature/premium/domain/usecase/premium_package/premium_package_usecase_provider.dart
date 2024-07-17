import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../premium/premium.dart';

final premiumPackageUseCaseProvider = Provider<PremiumPackageUseCase>((ref) {
  final authRepository = ref.watch(premiumRepositoryProvider);
  return PremiumPackageUseCase(authRepository);
});
