import 'package:dartz/dartz.dart';
import 'package:themovers/core/core.dart';
import 'package:themovers/feature/dashboard/dashboard.dart';
abstract class ImageSliderRepository {
  Future<Either<Failure, ImageSliderModel>> getImageSlider();

  Future<Either<Failure, TermsAndConditionModel>> getTermsAndCondition();

  Future<Either<Failure, TermsAndPoliciesModel>> getTermsAndPolicies();

  Future<Either<Failure, VersionModel>> getVersionCode();
}
