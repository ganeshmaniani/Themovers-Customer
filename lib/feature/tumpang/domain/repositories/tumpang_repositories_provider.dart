import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../tumpang/tumpang.dart';

final tumpangRepositoryProvider = Provider<TumpangRepository>((ref) {
  final remoteDataSource = ref.watch(tumpangDatasourceProvider);
  return TumpangRepositoryImpl(remoteDataSource);
});
