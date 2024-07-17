import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:themovers/core/core.dart';
import 'package:themovers/feature/faq_detail/data/data.dart';

final faqDataSourceProvider = Provider<FAQDataSource>((ref) {
  final apiServices = ref.watch(serviceProvider);
  return FAQDataSourceImpl(apiServices);
});
