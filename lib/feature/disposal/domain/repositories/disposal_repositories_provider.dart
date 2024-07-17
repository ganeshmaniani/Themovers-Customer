import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../disposal/disposal.dart';

final disposalRepositoryProvider = Provider<DisposalRepository>((ref) {
  final remoteDataSource = ref.watch(disposalDatasourceProvider);
  return DisposalRepositoryImpl(remoteDataSource);
});
