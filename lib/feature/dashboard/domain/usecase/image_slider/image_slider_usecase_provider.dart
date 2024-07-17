import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:themovers/feature/dashboard/dashboard.dart';
import 'package:themovers/feature/dashboard/domain/usecase/image_slider/image_slider_usecase.dart';

final imageSliderUseCaseProvider = Provider((ref) {
  final authRepository = ref.watch(imageSliderRepositoryProvider);
  return ImageSliderUseCase(authRepository);
});
