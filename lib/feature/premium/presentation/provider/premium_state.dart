import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class PremiumState extends Equatable {
  final bool isLoading;

  const PremiumState({
    required this.isLoading,
  });

  const PremiumState.initial({
    this.isLoading = false,
  });

  @override
  List<Object> get props => [
        isLoading,
      ];

  @override
  bool get stringify => true;

  PremiumState copyWith({
    bool? isLoading,
  }) {
    return PremiumState(
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
