import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth.dart';

final phoneNoUseCaseProvider = Provider<PhoneNoUseCase>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return PhoneNoUseCase(authRepository);
});
