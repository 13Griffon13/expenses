import 'package:finances/model/filter_settings.dart';

enum FilterStateStatus { success, error, initial }

class FilterState {
  FilterStateStatus status;
  FilterSettings settings;

  FilterState({required this.status, required this.settings});

  FilterState.initial()
      : status = FilterStateStatus.initial,
        settings = FilterSettings(
            from: DateTime.now().subtract(const Duration(days: 30),),
            to: DateTime.now());


}
