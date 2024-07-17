import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:themovers/feature/customer_profile/customer_profile.dart';

final customerDeleteAccountUseCaseProvider =
    Provider<CustomerDeleteAccountUseCase>((ref) {
  final authRepository = ref.watch(customerProfileRepositoryProvider);
  return CustomerDeleteAccountUseCase(authRepository);
});
