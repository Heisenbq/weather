part of 'hourly_forecast_bloc.dart';

abstract class HourlyForecastState {}

final class HourlyForecastInitial extends HourlyForecastState {}

class HourlyForecastLoading extends HourlyForecastState{}

class HourlyForecastLoadingError extends HourlyForecastState{}

class HourlyForecastLoaded extends HourlyForecastState{
  final List<HourlyForecast> forecast;

  HourlyForecastLoaded(this.forecast);
}

