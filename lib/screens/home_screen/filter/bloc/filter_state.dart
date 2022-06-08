import 'package:finances/model/filter_settings.dart';

enum FilterStateStatus { success, error, initial }

class FilterState {
  FilterStateStatus status;
  FilterSettings settings;

  FilterState({FilterStateStatus? status, FilterSettings? settings})
      : status = status ?? FilterStateStatus.initial,
        settings = settings ?? FilterSettings();
}
