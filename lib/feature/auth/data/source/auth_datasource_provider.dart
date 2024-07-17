import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/core.dart';
import '../../auth.dart';

final authDatasourceProvider = Provider<AuthDataSource>((ref) {
  final apiServices = ref.watch(serviceProvider);
  return AuthDataSourceImpl(apiServices);
});
