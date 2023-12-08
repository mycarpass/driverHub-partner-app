// ignore_for_file: must_be_immutable

import 'package:dh_state_management/dh_state.dart';
import 'package:driver_hub_partner/features/home/presenter/entities/bank_entity.dart';

class OnboardingState extends DHState {}

class BankSelected extends DHState {
  final BankEntity bankEntity;

  BankSelected({required this.bankEntity});
  @override
  List<Object?> get props => [bankEntity];
}
