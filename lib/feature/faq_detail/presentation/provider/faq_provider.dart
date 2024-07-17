import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:themovers/feature/faq_detail/domain/usecase/faq_detail/faq_detail.dart';
import 'package:themovers/feature/faq_detail/presentation/provider/faq_notifier.dart';
import 'package:themovers/feature/faq_detail/presentation/provider/faq_state.dart';

final faqDetailProvider =
    StateNotifierProvider<FAQListNotifier, FAQState>((ref) {
  final useCaseFAQList = ref.watch(faqListUseCaseProvider);
  return FAQListNotifier(useCaseFAQList);
});
