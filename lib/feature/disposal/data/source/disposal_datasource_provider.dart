import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/core.dart';
import '../../../disposal/disposal.dart';

final disposalDatasourceProvider = Provider<DisposalDataSource>((ref) {
  final apiServices = ref.watch(serviceProvider);
  return DisposalDataSourceImpl(apiServices);
});
