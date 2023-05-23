import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract class ApiState {}

class ApiLoadingState extends ApiState {}

class ApiSucessState extends ApiState {
  //final List<Data> dataList;

  //ApiSucessState(this.dataList);
}

class ApiErrorState extends ApiState {
  final String errorMessage;

  ApiErrorState(this.errorMessage);
}
