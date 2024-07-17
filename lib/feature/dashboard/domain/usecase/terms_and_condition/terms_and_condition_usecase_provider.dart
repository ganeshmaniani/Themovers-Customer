import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:themovers/feature/dashboard/domain/usecase/terms_and_condition/terms_and_condition.dart';

import '../../repositories/image_slider_repositories_provider.dart';

final termsAndConditionUseCaseProvider =
    Provider<TermsAndConditionUseCase>((ref) {
  final authRepository = ref.watch(imageSliderRepositoryProvider);
  return TermsAndConditionUseCase(authRepository);
});
