import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/core.dart';
import '../../../tumpang/tumpang.dart';

final tumpangDatasourceProvider = Provider<TumpangDataSource>((ref) {
  final apiServices = ref.watch(serviceProvider);
  return TumpangDataSourceImpl(apiServices);
});
