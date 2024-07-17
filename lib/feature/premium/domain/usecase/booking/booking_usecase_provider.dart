import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../premium/premium.dart';

final premiumBookingUseCaseProvider = Provider<PremiumBookingUseCase>((ref) {
  final authRepository = ref.watch(premiumRepositoryProvider);
  return PremiumBookingUseCase(authRepository);
});
