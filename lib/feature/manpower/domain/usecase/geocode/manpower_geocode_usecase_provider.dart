import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../manpower/manpower.dart';

final manpowerPlaceToGeocodeUseCaseProvider =
    Provider<ManpowerPlaceToGeocodeUseCase>((ref) {
  final authRepository = ref.watch(manpowerRepositoryProvider);
  return ManpowerPlaceToGeocodeUseCase(authRepository);
});
