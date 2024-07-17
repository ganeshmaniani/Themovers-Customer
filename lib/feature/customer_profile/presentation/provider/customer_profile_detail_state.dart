import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class CustomerProfileDetailState extends Equatable {
  final bool isLoading;

  const CustomerProfileDetailState({required this.isLoading});

  const CustomerProfileDetailState.initial({
    this.isLoading = false,
  });

  @override
  List<Object> get props => [isLoading];

  @override
  bool get stringify => true;

  CustomerProfileDetailState copyWith({
    bool? isLoading,
  }) {
    return CustomerProfileDetailState(isLoading: isLoading ?? this.isLoading);
  }
}
