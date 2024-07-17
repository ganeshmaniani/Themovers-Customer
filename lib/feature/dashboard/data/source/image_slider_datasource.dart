import 'package:dartz/dartz.dart';
import 'package:themovers/core/core.dart';
import 'package:themovers/feature/dashboard/dashboard.dart';
import 'package:themovers/feature/dashboard/data/model/term_and_condition_model.dart';
import 'package:themovers/feature/dashboard/data/model/terms_and_policy_model.dart';

abstract class ImageSliderDataSource {
  Future<Either<Failure, ImageSliderModel>> getImageSlider();

  Future<Either<Failure, TermsAndConditionModel>> getTermsAndCondition();

  Future<Either<Failure, TermsAndPoliciesModel>> getTermsAndPolicies();

  Future<Either<Failure, VersionModel>> getVersionCode();
}
