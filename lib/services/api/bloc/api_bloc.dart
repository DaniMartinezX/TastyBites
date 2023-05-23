import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasty_bites/services/api/bloc/api_event.dart';
import 'package:tasty_bites/services/api/bloc/api_state.dart';

class ApiBloc extends Bloc<ApiEvent, ApiState> {
  ApiBloc(super.initialState);
}
