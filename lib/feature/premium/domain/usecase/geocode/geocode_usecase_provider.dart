import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../premium/premium.dart';

final premiumPlaceToGeocodeUseCaseProvider =
    Provider<PremiumPlaceToGeocodeUseCase>((ref) {
  final authRepository = ref.watch(premiumRepositoryProvider);
  return PremiumPlaceToGeocodeUseCase(authRepository);
});
