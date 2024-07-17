import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../manpower/manpower.dart';

final manpowerPackageUseCaseProvider = Provider<ManpowerPackageUseCase>((ref) {
  final authRepository = ref.watch(manpowerRepositoryProvider);
  return ManpowerPackageUseCase(authRepository);
});
