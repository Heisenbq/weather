part of 'daily_forecast_bloc.dart';

abstract class DailyForecastState {}

final class DailyForecastInitial extends DailyForecastState {}

class DailyForecastLoading extends DailyForecastState{}

class DailyForecastLoadingError extends DailyForecastState{}

class DailyForecastLoaded extends DailyForecastState{
  final List<DailyForecast> forecast;

  DailyForecastLoaded(this.forecast);
}
