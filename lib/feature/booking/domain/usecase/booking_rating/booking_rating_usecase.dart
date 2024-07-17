import 'package:dartz/dartz.dart';
import 'package:themovers/core/core.dart';
import 'package:themovers/feature/booking/booking.dart';

class BookingRatingUseCase implements UseCase<dynamic, RatingEntities> {
  final BookingRepository _repository;

  BookingRatingUseCase(this._repository);

  @override
  Future<Either<Failure, dynamic>> call(RatingEntities ratingEntities) async {
    return await _repository.uploadRating(ratingEntities);
  }
}
