import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:themovers/feature/dashboard/dashboard.dart';
import 'package:themovers/feature/dashboard/domain/usecase/image_slider/image_slider_usecase_provider.dart';
import 'package:themovers/feature/dashboard/domain/usecase/terms_and_condition/terms_and_condition.dart';

import '../../domain/usecase/terms_and_policies/terms_and_policies_usecase_provider.dart';

final imageSliderProvider =
    StateNotifierProvider<ImageSliderNotifier, ImageSliderState>((ref) {
  final useCaseImageSlider = ref.watch(imageSliderUseCaseProvider);
  final useCaseTermsAndCondition = ref.watch(termsAndConditionUseCaseProvider);
  final useCaseTermsAndPolicies = ref.watch(termsAndPoliciesUseCaseProvider);
  final useCaseVersionCode = ref.watch(versionCodeUseCaseProvider);
  return ImageSliderNotifier(useCaseImageSlider, useCaseTermsAndCondition,
      useCaseTermsAndPolicies, useCaseVersionCode);
});
