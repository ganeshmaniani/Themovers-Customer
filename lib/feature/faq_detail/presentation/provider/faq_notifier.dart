import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:themovers/core/core.dart';
import 'package:themovers/feature/faq_detail/data/data.dart';
import 'package:themovers/feature/faq_detail/domain/usecase/faq_detail/faq_detail.dart';
import 'package:themovers/feature/faq_detail/presentation/provider/faq_state.dart';

class FAQListNotifier extends StateNotifier<FAQState> {
  final FAQDetailUseCase _faqDetailUseCase;

  FAQListNotifier(this._faqDetailUseCase) :super(const FAQState.initial());

  Future<Either<Failure, CustomerFAQModel>> getFAQList() async {
    state.copyWith(isLoading: true);
    final result = await _faqDetailUseCase();
    state.copyWith(isLoading: false);
    return result;
  }
}