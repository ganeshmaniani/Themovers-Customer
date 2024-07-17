import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class BookingState extends Equatable {
  final bool isLoading;

  const BookingState({
    required this.isLoading,
  });

  const BookingState.initial({
    this.isLoading = false,
  });

  @override
  List<Object> get props => [
        isLoading,
      ];

  @override
  bool get stringify => true;

  BookingState copyWith({
    bool? isLoading,
  }) {
    return BookingState(
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
