import 'package:bloc/bloc.dart';

import '../../api_actions/weather_api.dart';
import '../../model/hourly_forecast.dart';
import '../../repository/weather_repository.dart';

part 'hourly_forecast_event.dart';
part 'hourly_forecast_state.dart';

class HourlyForecastBloc extends Bloc<HourlyForecastEvent, HourlyForecastState> {

  final WeatherRepository hourlyForecastRepository;

  HourlyForecastBloc(this.hourlyForecastRepository) : super(HourlyForecastInitial()) {
    on<FetchHourlyForecast>((event, emit) async {
      emit(HourlyForecastLoading());
      try {
        // final forecast = await hourlyForecastRepository.getHourlyForecast();
        final forecast = await hourlyForecastRepository.getHourlyForecast(event.city);
        emit(HourlyForecastLoaded(forecast));
      } catch (e) {
        emit(HourlyForecastLoadingError());
      }
    });
  }
}
