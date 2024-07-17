import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:themovers/feature/customer_profile/customer_profile.dart';

final customerProfileDetailUseCaseProvider =
    Provider<CustomerProfileDetailUseCase>((ref) {
  final authRepository = ref.watch(customerProfileRepositoryProvider);
  return CustomerProfileDetailUseCase(authRepository);
});
