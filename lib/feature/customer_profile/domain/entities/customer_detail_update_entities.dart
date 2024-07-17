import 'package:equatable/equatable.dart';

class CustomerDetailUpdateEntities extends Equatable {
  final String id;
  final String customerName;
  final String emailId;
  final String mobileNumber;


  const CustomerDetailUpdateEntities({
    required this.id,
    required this.customerName,
    required this.emailId,
    required this.mobileNumber,

  });

  @override
  List<Object?> get props {
    return [id, customerName, emailId, mobileNumber];
  }

  @override
  bool get stringify => true;

  CustomerDetailUpdateEntities copyWith({final String? id,
    final String? customerName,
    final String? emailId,
    final String? mobileNumber,
  }) {
    return CustomerDetailUpdateEntities(
      id: id ?? this.id,
      customerName: customerName ?? this.customerName,
      emailId: emailId ?? this.emailId,
      mobileNumber: mobileNumber ?? this.mobileNumber,
    );
  }
}
