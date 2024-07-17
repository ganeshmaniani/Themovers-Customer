import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class ManpowerState extends Equatable {
  final bool isLoading;

  const ManpowerState({required this.isLoading});

  const ManpowerState.initial({this.isLoading = false});

  @override
  List<Object> get props => [isLoading];

  @override
  bool get stringify => true;

  ManpowerState copyWith({bool? isLoading}) {
    return ManpowerState(isLoading: isLoading ?? this.isLoading);
  }
}
