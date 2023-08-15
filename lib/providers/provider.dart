import 'package:flutter_riverpod/flutter_riverpod.dart';

final heightProvider = StateProvider<double>((ref) {
  return 100;
});
final weightProvider = StateProvider<double>((ref) {
  return 50;
});
final bmiProvider = StateProvider<double>((ref) {
  return 0;
});

final bmiclearProvider = StateProvider<bool>((ref) {
  return false;
});
