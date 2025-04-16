part of 'weather_bloc.dart';

abstract class WeatherState {}

final class WeatherInitial extends WeatherState {}

class HourlyForecastLoading extends WeatherState{}

class HourlyForecastLoadingError extends WeatherState{}

class HourlyForecastLoaded extends WeatherState{
  final List<HourlyForecast> forecast;

  HourlyForecastLoaded(this.forecast);
}
