import 'package:equatable/equatable.dart';

class DisposalPlaceEntities extends Equatable {
  final String query;
  final String key;

  const DisposalPlaceEntities({
    required this.query,
    required this.key,
  });

  @override
  List<Object> get props {
    return [
      query,
      key,
    ];
  }

  @override
  bool get stringify => true;

  DisposalPlaceEntities copyWith({
    final String? query,
    final String? key,
  }) {
    return DisposalPlaceEntities(
      query: query ?? this.query,
      key: key ?? this.key,
    );
  }
}
