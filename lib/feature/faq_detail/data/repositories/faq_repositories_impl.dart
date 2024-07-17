import 'package:dartz/dartz.dart';
import 'package:themovers/core/errors/failure.dart';
import 'package:themovers/feature/faq_detail/data/model/customer_faq_model.dart';
import 'package:themovers/feature/faq_detail/data/source/faq_datasource.dart';
import 'package:themovers/feature/faq_detail/domain/repositories/faq_repositories.dart';

class FAQRepositoryImpl implements FAQRepository {
  final FAQDataSource _faqDataSource;

  FAQRepositoryImpl(this._faqDataSource);

  @override
  Future<Either<Failure, CustomerFAQModel>> getFAQList() async {
    return _faqDataSource.getFAQList();
  }
}
