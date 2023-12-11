// ignore_for_file: must_be_immutable

import 'package:dh_state_management/dh_state.dart';

class SubscriptionState extends DHState {}

class SubscriptionSuccessState extends DHSuccessState {}

class PlanIsSelected extends DHState {
  final int index;

  PlanIsSelected({required this.index});
  @override
  List<Object?> get props => [index];
}

class SubscribedIsUpdated extends DHState {
  final bool isSubscribed;

  SubscribedIsUpdated({required this.isSubscribed});
  @override
  List<Object?> get props => [isSubscribed];
}
