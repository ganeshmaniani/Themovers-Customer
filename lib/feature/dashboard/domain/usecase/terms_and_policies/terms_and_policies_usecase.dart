import 'package:dartz/dartz.dart';
import 'package:themovers/feature/dashboard/data/model/terms_and_policy_model.dart';

import '../../../../../core/errors/failure.dart';
import '../../repositories/image_slider_repositories.dart';

class TermsAndPoliciesUseCase {
  final ImageSliderRepository _repository;

  TermsAndPoliciesUseCase(this._repository);

  Future<Either<Failure, TermsAndPoliciesModel>> call() async {
    return await _repository.getTermsAndPolicies();
  }
}
