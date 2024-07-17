import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core.dart';

final serviceProvider = Provider<BaseApiServices>((ref) {
  return NetworkApiService();
});
