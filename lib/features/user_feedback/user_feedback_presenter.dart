import 'package:dh_state_management/dh_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserFeedbackPresenter extends Cubit<DHState> {
  UserFeedbackPresenter() : super(DHInitialState());
}
