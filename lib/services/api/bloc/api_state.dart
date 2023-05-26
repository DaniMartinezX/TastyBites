import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract class ApiState {
  final bool isLoading;
  final String? loadingText;
  const ApiState({required this.isLoading, this.loadingText = 'Loading data'});
}
