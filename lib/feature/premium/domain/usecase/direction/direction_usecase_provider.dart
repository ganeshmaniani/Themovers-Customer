import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../premium/premium.dart';

final premiumDirectionUseCaseProvider =
    Provider<PremiumDirectionUseCase>((ref) {
  final authRepository = ref.watch(premiumRepositoryProvider);
  return PremiumDirectionUseCase(authRepository);
});
