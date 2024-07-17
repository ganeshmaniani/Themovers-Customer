import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../premium/premium.dart';

final premiumPlaceUseCaseProvider = Provider<PremiumPlaceUseCase>((ref) {
  final authRepository = ref.watch(premiumRepositoryProvider);
  return PremiumPlaceUseCase(authRepository);
});
