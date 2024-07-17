import 'package:dartz/dartz.dart';
import 'package:themovers/core/core.dart';

import '../../data/model/customer_faq_model.dart';

abstract class FAQRepository {
  Future<Either<Failure, CustomerFAQModel>> getFAQList();
}
