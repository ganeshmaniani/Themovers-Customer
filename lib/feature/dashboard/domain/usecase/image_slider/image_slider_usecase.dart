import 'package:dartz/dartz.dart';
import 'package:themovers/feature/dashboard/dashboard.dart';

import '../../../../../core/errors/failure.dart';

class ImageSliderUseCase {
  final ImageSliderRepository _repository;

  ImageSliderUseCase(this._repository);

  Future<Either<Failure, ImageSliderModel>> call() async {
    return await _repository.getImageSlider();
  }
}
