import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:themovers/core/core.dart';
import 'package:themovers/feature/dashboard/dashboard.dart';

import '../../domain/usecase/image_slider/image_slider_usecase.dart';

class ImageSliderNotifier extends StateNotifier<ImageSliderState> {
  final ImageSliderUseCase _imageSliderUseCase;
  final TermsAndConditionUseCase _termsAndConditionUseCase;
  final TermsAndPoliciesUseCase _termsAndPoliciesUseCase;
  final VersionCodeUseCase _versionCodeUseCase;

  ImageSliderNotifier(this._imageSliderUseCase, this._termsAndConditionUseCase,
      this._termsAndPoliciesUseCase, this._versionCodeUseCase)
      : super(const ImageSliderState.initial());

  Future<Either<Failure, ImageSliderModel>> getImageSlider() async {
    state.copyWith(isLoading: true);
    final result = await _imageSliderUseCase();
    state.copyWith(isLoading: false);
    return result;
  }

  Future<Either<Failure, TermsAndConditionModel>> getTermsAndCondition() async {
    state.copyWith(isLoading: true);
    final result = await _termsAndConditionUseCase();
    state.copyWith(isLoading: false);
    return result;
  }

  Future<Either<Failure, TermsAndPoliciesModel>> getTermsAndPolicies() async {
    state.copyWith(isLoading: true);
    final result = await _termsAndPoliciesUseCase();
    state.copyWith(isLoading: false);
    return result;
  }

  Future<Either<Failure, VersionModel>> getVersionCode() async {
    state.copyWith(isLoading: true);
    final result = await _versionCodeUseCase();
    state.copyWith(isLoading: false);
    return result;
  }
}
