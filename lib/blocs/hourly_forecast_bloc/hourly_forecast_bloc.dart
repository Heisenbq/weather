import 'package:bloc/bloc.dart';

import '../../model/hourly_forecast.dart';
import '../../repository/hourly_forecast_repository.dart';

part 'hourly_forecast_event.dart';
part 'hourly_forecast_state.dart';

class HourlyForecastBloc extends Bloc<HourlyForecastEvent, HourlyForecastState> {

  final HourlyForecastRepository hourlyForecastRepository;

  HourlyForecastBloc(this.hourlyForecastRepository) : super(HourlyForecastInitial()) {
    on<FetchHourlyForecast>((event, emit) async {
      emit(HourlyForecastLoading());
      try {
        final forecast = await hourlyForecastRepository.getHourlyForecast();
        emit(HourlyForecastLoaded(forecast));
      } catch (e) {
        emit(HourlyForecastLoadingError());
      }
    });
  }
}
