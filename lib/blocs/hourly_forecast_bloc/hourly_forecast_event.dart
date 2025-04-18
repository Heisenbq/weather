part of 'hourly_forecast_bloc.dart';

abstract class HourlyForecastEvent {}

class FetchHourlyForecast extends HourlyForecastEvent{
  final String city;

  FetchHourlyForecast(this.city);
}
