import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/core.dart';
import '../../../manpower/manpower.dart';

final manpowerDatasourceProvider = Provider<ManpowerDataSource>((ref) {
  final apiServices = ref.watch(serviceProvider);
  return ManpowerDataSourceImpl(apiServices);
});
