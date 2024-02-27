import 'package:flutter_riverpod/flutter_riverpod.dart';

final flyAnimationIndexProvider = StateProvider.autoDispose<int>((ref) {
  return 0;
});