import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:themovers/feature/dashboard/domain/repositories/image_slider_repositories.dart';

import '../../data/repositories/image_slider_repositories_impl.dart';
import '../../data/source/image_slider_datasource_provider.dart';

final imageSliderRepositoryProvider = Provider<ImageSliderRepository>((ref) {
  final remoteDataSource = ref.watch(imageSliderDataSourceProvider);
  return ImageSliderRepositoryImpl(remoteDataSource);
});
