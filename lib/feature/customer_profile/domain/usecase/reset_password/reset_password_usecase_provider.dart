import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:themovers/feature/customer_profile/customer_profile.dart';

final resetPasswordUseCaseProvider = Provider<ResetPasswordUseCase>((ref) {
  final customerProfileRepository =
      ref.watch(customerProfileRepositoryProvider);
  return ResetPasswordUseCase(customerProfileRepository);
});
