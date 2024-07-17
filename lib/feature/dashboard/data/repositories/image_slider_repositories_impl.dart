import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../../../feature.dart';

class ImageSliderRepositoryImpl implements ImageSliderRepository {
  final ImageSliderDataSource _imageSliderDataSource;

  ImageSliderRepositoryImpl(this._imageSliderDataSource);

  @override
  Future<Either<Failure, ImageSliderModel>> getImageSlider() async {
    return await _imageSliderDataSource.getImageSlider();
  }

  @override
  Future<Either<Failure, TermsAndConditionModel>> getTermsAndCondition() async {
    return await _imageSliderDataSource.getTermsAndCondition();
  }

  @override
  Future<Either<Failure, TermsAndPoliciesModel>> getTermsAndPolicies() async {
    return await _imageSliderDataSource.getTermsAndPolicies();
  }

  @override
  Future<Either<Failure, VersionModel>> getVersionCode() async {
    return await _imageSliderDataSource.getVersionCode();
  }
}
