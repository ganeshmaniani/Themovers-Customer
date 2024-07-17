import 'package:dartz/dartz.dart';
import 'package:themovers/feature/dashboard/dashboard.dart';
import 'package:themovers/feature/dashboard/data/model/term_and_condition_model.dart';

import '../../../../../core/errors/failure.dart';

class TermsAndConditionUseCase {
  final ImageSliderRepository _repository;

  TermsAndConditionUseCase(this._repository);

  Future<Either<Failure, TermsAndConditionModel>> call() async {
    return await _repository.getTermsAndCondition();
  }
}
