import 'package:bloc/bloc.dart';
import 'package:test_flutter_app/model/daily_forecast.dart';
import 'package:test_flutter_app/repository/daily_forecast_repository.dart';

import '../../repository/weather_repository.dart';

part 'daily_forecast_event.dart';
part 'daily_forecast_state.dart';

class DailyForecastBloc extends Bloc<DailyForecastEvent, DailyForecastState> {
  final WeatherRepository dailyForecastRepository;

  DailyForecastBloc(this.dailyForecastRepository)
    : super(DailyForecastInitial()) {
    on<FetchDailyForecast>((event, emit) async {
      emit(DailyForecastLoading());
      try {
        final forecast = await dailyForecastRepository.getDailyForecast("Moscow");
        emit(DailyForecastLoaded(forecast));
      } catch (e) {
        emit(DailyForecastLoadingError());
      }
    });
  }
}
