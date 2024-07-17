import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:themovers/feature/customer_profile/customer_profile.dart';
import 'package:themovers/feature/customer_profile/domain/usecase/customer_detail_update/customer_detail_upadte_usecase_provider.dart';
import 'package:themovers/feature/customer_profile/domain/usecase/customer_profile_image_update/customer_profile_image_update.dart';

import 'customer_profile_detail_change_notifier.dart';

final customerDetailUpdateNotifierProvider =
    ChangeNotifierProvider<CustomerDetailUpdateChangeNotifier>((ref) {
  return CustomerDetailUpdateChangeNotifier();
});

final customerProfileDetailProvider = StateNotifierProvider<
    CustomerProfileDetailNotifier, CustomerProfileDetailState>((ref) {
  final useCaseCustomerProfileDetail =
      ref.watch(customerProfileDetailUseCaseProvider);
  final useCaseResetPassword = ref.watch(resetPasswordUseCaseProvider);
  final useCaseCustomerDetailUpdate =
      ref.watch(customerDetailUpdateUseCaseProvider);

  final useCaseCustomerDeleteAccountProvider =
      ref.watch(customerDeleteAccountUseCaseProvider);
  final useCaseCustomerProfileImageUpdateProvider =
      ref.watch(customerProfileImageUpdateUseCaseProvider);
  return CustomerProfileDetailNotifier(
      useCaseCustomerProfileDetail,
      useCaseResetPassword,
      useCaseCustomerDetailUpdate,
      useCaseCustomerDeleteAccountProvider,
      useCaseCustomerProfileImageUpdateProvider);
});
