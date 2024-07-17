import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../manpower/manpower.dart';

final manpowerBookingUseCaseProvider = Provider<ManpowerBookingUseCase>((ref) {
  final authRepository = ref.watch(manpowerRepositoryProvider);
  return ManpowerBookingUseCase(authRepository);
});
