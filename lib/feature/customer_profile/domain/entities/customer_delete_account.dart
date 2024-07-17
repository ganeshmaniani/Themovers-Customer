import 'package:equatable/equatable.dart';

class CustomerDeleteAccountEntities extends Equatable {

  final String userId;

  const CustomerDeleteAccountEntities({required this.userId });

  @override
  List<Object?> get props {
    return [userId];
  }

  @override
  bool get stringify => true;

  CustomerDeleteAccountEntities copyWith({ final String? userId}) {
    return CustomerDeleteAccountEntities(userId: userId ?? this.userId);
  }
}
