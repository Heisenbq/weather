
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_app/repository/hourly_forecast_repository.dart';

import '../model/hourly_forecast.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {

  final HourlyForecastRepository hourlyForecastRepository;


  WeatherBloc(this.hourlyForecastRepository) : super(WeatherInitial()) {
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
