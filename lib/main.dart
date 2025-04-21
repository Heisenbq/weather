import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_app/api_actions/weather_api.dart';
import 'package:test_flutter_app/blocs/current_weather_bloc/current_weather_bloc.dart';
import 'package:test_flutter_app/blocs/hourly_forecast_bloc/hourly_forecast_bloc.dart';
import 'package:test_flutter_app/repository/weather_repository.dart';
import 'package:test_flutter_app/widgets/daily_forecast_list.dart';
import 'package:test_flutter_app/widgets/hourly_forecast_list.dart';
import 'package:test_flutter_app/widgets/weather_at_this_moment.dart';

import 'blocs/daily_forecast_bloc/daily_forecast_bloc.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HourlyForecastBloc>(
          create: (context) => HourlyForecastBloc(WeatherRepository(WeatherApi())),
        ),
        BlocProvider<DailyForecastBloc>(
          create: (context) => DailyForecastBloc(WeatherRepository(WeatherApi())),
        ),
        BlocProvider<CurrentWeatherBloc>(
          create: (context) => CurrentWeatherBloc(WeatherRepository(WeatherApi())),
        ),
      ],
      child: MaterialApp(
        title: 'Weather App',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const WeatherScreen(),
      ),
    );
  }
}

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF7F9BBC),
              Color(0xFF6480AD),
              Color(0xFF5C9BDB),
            ],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 75),
                WeatherAtThisMoment(),
                const SizedBox(height: 24),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  decoration: BoxDecoration(
                    color: Color(0xFF2270BB),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: HourlyForecastList(),
                ),
                const SizedBox(height: 32),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    decoration: BoxDecoration(
                      color: Color(0xFF2270BB),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: DailyForecastList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}






