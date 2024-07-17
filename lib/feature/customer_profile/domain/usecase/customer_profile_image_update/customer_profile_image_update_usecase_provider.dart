import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:themovers/feature/customer_profile/domain/usecase/customer_profile_image_update/customer_profile_image_update.dart';

import '../../repositories/customer_profile_repositories_provider.dart';

final customerProfileImageUpdateUseCaseProvider = Provider<
    CustomerProfileImageUpdateUseCase>((ref) {
  final authRepository = ref.watch(customerProfileRepositoryProvider);
  return CustomerProfileImageUpdateUseCase(authRepository);
});