import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class BudgetState extends Equatable {
  final bool isLoading;

  const BudgetState({
    required this.isLoading,
  });

  const BudgetState.initial({
    this.isLoading = false,
  });

  @override
  List<Object> get props => [
        isLoading,
      ];

  @override
  bool get stringify => true;

  BudgetState copyWith({
    bool? isLoading,
  }) {
    return BudgetState(
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
