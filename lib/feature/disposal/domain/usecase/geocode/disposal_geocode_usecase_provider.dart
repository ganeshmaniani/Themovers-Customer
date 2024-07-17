import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../disposal/disposal.dart';

final disposalPlaceToGeocodeUseCaseProvider =
    Provider<DisposalPlaceToGeocodeUseCase>((ref) {
  final authRepository = ref.watch(disposalRepositoryProvider);
  return DisposalPlaceToGeocodeUseCase(authRepository);
});
