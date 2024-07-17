import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:themovers/feature/customer_profile/customer_profile.dart';
import 'package:themovers/feature/customer_profile/domain/usecase/customer_detail_update/customer_detail_update.dart';

final customerDetailUpdateUseCaseProvider =
    Provider<CustomerDetailUpdateUseCase>((ref) {
  final authRepository = ref.watch(customerProfileRepositoryProvider);
  return CustomerDetailUpdateUseCase(authRepository);
});
