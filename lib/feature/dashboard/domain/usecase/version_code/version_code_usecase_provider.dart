import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../feature.dart';

final versionCodeUseCaseProvider = Provider<VersionCodeUseCase>((ref) {
  final authRepository = ref.watch(imageSliderRepositoryProvider);
  return VersionCodeUseCase(authRepository);
});
