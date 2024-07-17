import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:themovers/feature/faq_detail/data/repositories/faq_repositories_impl.dart';
import 'package:themovers/feature/faq_detail/data/source/faq_datasource_provider.dart';
import 'package:themovers/feature/faq_detail/domain/repositories/faq_repositories.dart';

final faqRepositoriesProvider = Provider<FAQRepository>((ref) {
  final remoteDataSource = ref.watch(faqDataSourceProvider);
  return FAQRepositoryImpl(remoteDataSource);
});
