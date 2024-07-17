import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../manpower/manpower.dart';

final manpowerRepositoryProvider = Provider<ManpowerRepository>((ref) {
  final remoteDataSource = ref.watch(manpowerDatasourceProvider);
  return ManpowerRepositoryImpl(remoteDataSource);
});
