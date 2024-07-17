import 'package:equatable/equatable.dart';

class RatingEntities extends Equatable {
  final String userId;
  final String bookingId;
  final String ratings;
  final String feedback;

  const RatingEntities(
      {required this.userId,
      required this.bookingId,
      required this.ratings,
      required this.feedback});

  @override
  List<Object> get props {
    return [userId, bookingId, ratings, feedback];
  }

  @override
  bool get stringify => true;

  RatingEntities copyWith({
    final String? userId,
    final String? bookingId,
    final String? ratings,
    final String? feedback,
  }) {
    return RatingEntities(
      userId: userId ?? this.userId,
      bookingId: bookingId ?? this.bookingId,
      ratings: ratings ?? this.ratings,
      feedback: feedback ?? this.feedback,
    );
  }
}
