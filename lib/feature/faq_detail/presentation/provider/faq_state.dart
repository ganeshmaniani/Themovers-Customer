import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
class FAQState extends Equatable {
  final bool isLoading;

  const FAQState({required this.isLoading});

  const FAQState.initial({this.isLoading = false});

  @override
  List<Object> get props => [isLoading];

  @override
  bool get stringify => true;

  FAQState copyWith({bool? isLoading}) {
    return FAQState(isLoading: isLoading ?? this.isLoading);
  }
}
