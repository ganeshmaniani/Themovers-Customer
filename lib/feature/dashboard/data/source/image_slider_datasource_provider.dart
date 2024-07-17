import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:themovers/core/core.dart';

import 'image_slider_datasource_impl.dart';

final imageSliderDataSourceProvider = Provider((ref) {
  final apiServices = ref.watch(serviceProvider);
  return ImageSliderDataSourceImpl(apiServices);
});
