import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:themovers/feature/dashboard/domain/usecase/terms_and_policies/terms_and_policies.dart';

import '../../repositories/image_slider_repositories_provider.dart';

final termsAndPoliciesUseCaseProvider =
    Provider<TermsAndPoliciesUseCase>((ref) {
  final authRepository = ref.watch(imageSliderRepositoryProvider);
  return TermsAndPoliciesUseCase(authRepository);
});
