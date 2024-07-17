import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../premium/premium.dart';

final premiumLongPushTypeUseCaseProvider =
    Provider<PremiumLongPushTypeUseCase>((ref) {
  final authRepository = ref.watch(premiumRepositoryProvider);
  return PremiumLongPushTypeUseCase(authRepository);
});
