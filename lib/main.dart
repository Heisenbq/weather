import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_app/api_actions/weather_api.dart';
import 'package:test_flutter_app/blocs/current_weather_bloc/current_weather_bloc.dart';
import 'package:test_flutter_app/blocs/hourly_forecast_bloc/hourly_forecast_bloc.dart';
import 'package:test_flutter_app/pages/home_page.dart';
import 'package:test_flutter_app/repository/weather_repository.dart';

import 'blocs/daily_forecast_bloc/daily_forecast_bloc.dart';

void main() {
  runApp(WeatherApp());
}

class WeatherApp extends StatelessWidget {
  WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HourlyForecastBloc>(
          create:
              (context) => HourlyForecastBloc(WeatherRepository(WeatherApi())),
        ),
        BlocProvider<DailyForecastBloc>(
          create:
              (context) => DailyForecastBloc(WeatherRepository(WeatherApi())),
        ),
        BlocProvider<CurrentWeatherBloc>(
          create:
              (context) => CurrentWeatherBloc(WeatherRepository(WeatherApi())),
        ),
      ],
      child: MaterialApp(
        title: 'Weather App',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: HomePage(),
      ),
    );
  }
}

