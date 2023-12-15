import 'package:dh_state_management/dh_state.dart';

class NewSaleCreated extends DHState {
  @override
  List<Object?> get props => [];
}

class NewSaleDateSeleceted extends DHState {
  final String newDate;

  NewSaleDateSeleceted(this.newDate);

  @override
  List<Object?> get props => [newDate];
}

class DiscountApliedState extends DHState {
  final double discountValue;

  DiscountApliedState({required this.discountValue});

  @override
  List<Object?> get props => [discountValue];
}
