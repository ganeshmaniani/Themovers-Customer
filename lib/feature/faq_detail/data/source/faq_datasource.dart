import 'package:dartz/dartz.dart';
import 'package:themovers/core/core.dart';
import 'package:themovers/feature/faq_detail/data/data.dart';

abstract class FAQDataSource {
  Future<Either<Failure, CustomerFAQModel>> getFAQList();
}
