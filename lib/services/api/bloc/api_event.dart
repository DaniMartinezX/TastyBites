import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract class ApiEvent {
  const ApiEvent();
}

class FetchDataEvent extends ApiEvent {}
