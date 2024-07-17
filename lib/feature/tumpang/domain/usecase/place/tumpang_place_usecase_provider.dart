import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../tumpang/tumpang.dart';

final tumpangPlaceUseCaseProvider = Provider<TumpangPlaceUseCase>((ref) {
  final authRepository = ref.watch(tumpangRepositoryProvider);
  return TumpangPlaceUseCase(authRepository);
});
