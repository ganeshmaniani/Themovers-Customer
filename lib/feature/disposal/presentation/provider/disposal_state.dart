import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class DisposalState extends Equatable {
  final bool isLoading;

  const DisposalState({
    required this.isLoading,
  });

  const DisposalState.initial({
    this.isLoading = false,
  });

  @override
  List<Object> get props => [
        isLoading,
      ];

  @override
  bool get stringify => true;

  DisposalState copyWith({
    bool? isLoading,
  }) {
    return DisposalState(
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
