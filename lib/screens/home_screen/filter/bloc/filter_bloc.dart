import 'package:finances/model/filter_settings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'filter_event.dart';
import 'filter_state.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  FilterBloc(FilterState initialState) : super(initialState) {
    on<FromChanged>((event, emit) {
      emit(
        FilterState(
          settings: FilterSettings(
            to: state.settings.to,
            from: event.dateTime,
            categories: state.settings.categories,
          ),
          status: FilterStateStatus.success,
        ),
      );
    });
    on<ToChanged>((event, emit) {
      emit(
        FilterState(
          settings: FilterSettings(
            to: event.dateTime,
            from: state.settings.from,
            categories: state.settings.categories,
          ),
          status: FilterStateStatus.success,
        ),
      );
    });
    on<CategoryChanged>((event, emit) {
      emit(
        FilterState(
          settings: FilterSettings(
            to: state.settings.to,
            from: state.settings.from,
            categories: event.categories,
          ),
          status: FilterStateStatus.success,
        ),
      );
    });
    on<ResetFilters>((event,emit){
      emit(FilterState.initial());
    });
  }
}
