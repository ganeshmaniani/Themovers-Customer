import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:themovers/feature/faq_detail/domain/repositories/faq_repositories_provider.dart';
import 'package:themovers/feature/faq_detail/domain/usecase/faq_detail/faq_detail.dart';

final faqListUseCaseProvider = Provider<FAQDetailUseCase>((ref) {
  final authRepository = ref.watch(faqRepositoriesProvider);
  return FAQDetailUseCase(authRepository);
});
