import 'package:hooks_riverpod/hooks_riverpod.dart';

final isLoadingProvider =
    StateNotifierProvider<RegularButtonLoadingNotifier, Map<String, bool>>(
        (ref) => RegularButtonLoadingNotifier());

class RegularButtonLoadingNotifier extends StateNotifier<Map<String, bool>> {
  RegularButtonLoadingNotifier() : super({});

  void setLoading(String buttonKey, bool isLoading) {
    state = {...state, buttonKey: isLoading};
  }
}
