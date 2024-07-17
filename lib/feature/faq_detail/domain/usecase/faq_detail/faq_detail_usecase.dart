import 'package:dartz/dartz.dart';
import 'package:themovers/core/core.dart';
import 'package:themovers/feature/faq_detail/data/data.dart';
import 'package:themovers/feature/faq_detail/domain/repositories/faq_repositories.dart';

class FAQDetailUseCase {
  final FAQRepository _repository;

  FAQDetailUseCase(this._repository);

  Future<Either<Failure, CustomerFAQModel>> call() async {
    return await _repository.getFAQList();
  }
}
