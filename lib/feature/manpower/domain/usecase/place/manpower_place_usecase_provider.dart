import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../manpower/manpower.dart';

final manpowerPlaceUseCaseProvider = Provider<ManpowerPlaceUseCase>((ref) {
  final authRepository = ref.watch(manpowerRepositoryProvider);
  return ManpowerPlaceUseCase(authRepository);
});
