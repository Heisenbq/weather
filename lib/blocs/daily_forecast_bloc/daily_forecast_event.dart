part of 'daily_forecast_bloc.dart';

abstract class DailyForecastEvent {}

class FetchDailyForecast extends DailyForecastEvent{
  final String city;

  FetchDailyForecast(this.city);
}
