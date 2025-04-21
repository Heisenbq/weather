import 'package:bloc/bloc.dart';
import 'package:test_flutter_app/model/daily_forecast.dart';

import '../../repository/weather_repository.dart';
import '../../service/location_service.dart';

part 'daily_forecast_event.dart';
part 'daily_forecast_state.dart';

class DailyForecastBloc extends Bloc<DailyForecastEvent, DailyForecastState> {
  final WeatherRepository dailyForecastRepository;

  DailyForecastBloc(this.dailyForecastRepository)
    : super(DailyForecastInitial()) {
    on<FetchDailyForecast>((event, emit) async {
      emit(DailyForecastLoading());
      try {
        List<DailyForecast> forecast;
        if (event.city!=null) {
          forecast = await dailyForecastRepository.getDailyForecast(event.city!);
        }
        else {
          LocationService
          forecast = await dailyForecastRepository.getDailyForecastByCoordinates(lat, lon)
        }
        // final position = await LocationService.getCurrentPosition();
        // final city = await LocationService.getCityName(
        //   position.latitude,
        //   position.longitude,
        // );
        // final forecast = await dailyForecastRepository.getDailyForecast(city);
        emit(DailyForecastLoaded(forecast));
      } catch (e) {
        emit(DailyForecastLoadingError());
      }
    });
  }
}
