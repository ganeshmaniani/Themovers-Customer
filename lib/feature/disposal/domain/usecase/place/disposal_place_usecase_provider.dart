import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../disposal/disposal.dart';

final disposalPlaceUseCaseProvider = Provider<DisposalPlaceUseCase>((ref) {
  final authRepository = ref.watch(disposalRepositoryProvider);
  return DisposalPlaceUseCase(authRepository);
});
