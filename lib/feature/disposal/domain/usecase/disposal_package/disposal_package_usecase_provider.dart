import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../disposal/disposal.dart';

final disposalPackageUseCaseProvider = Provider<DisposalPackageUseCase>((ref) {
  final authRepository = ref.watch(disposalRepositoryProvider);
  return DisposalPackageUseCase(authRepository);
});
