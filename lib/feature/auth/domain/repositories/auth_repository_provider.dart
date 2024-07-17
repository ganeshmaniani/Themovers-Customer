import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final remoteDataSource = ref.watch(authDatasourceProvider);
  return AuthRepositoryImpl(remoteDataSource);
});
