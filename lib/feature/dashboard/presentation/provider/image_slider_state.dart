import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class ImageSliderState extends Equatable {
  final bool isLoading;

  const ImageSliderState({required this.isLoading});

  const ImageSliderState.initial({
    this.isLoading = false,
  });

  @override
  List<Object> get props => [isLoading];

  @override
  bool get stringify => true;

  ImageSliderState copyWith({
    bool? isLoading
  }) {
    return ImageSliderState(isLoading: isLoading ?? this.isLoading);
  }
}


