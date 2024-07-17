import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class TumpangState extends Equatable {
  final bool isLoading;

  const TumpangState({
    required this.isLoading,
  });

  const TumpangState.initial({
    this.isLoading = false,
  });

  @override
  List<Object> get props => [
        isLoading,
      ];

  @override
  bool get stringify => true;

  TumpangState copyWith({
    bool? isLoading,
  }) {
    return TumpangState(
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
