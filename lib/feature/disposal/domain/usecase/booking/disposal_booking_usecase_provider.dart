import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../disposal.dart';

final disposalBookingUseCaseProvider = Provider<DisposalBookingUseCase>((ref) {
  final authRepository = ref.watch(disposalRepositoryProvider);
  return DisposalBookingUseCase(authRepository);
});
