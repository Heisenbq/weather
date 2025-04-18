import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_app/model/current_weather.dart';

import '../blocs/current_weather_bloc/current_weather_bloc.dart';

class WeatherAtThisMoment extends StatelessWidget {

  const WeatherAtThisMoment({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentWeatherBloc, CurrentWeatherState>(
        builder: (context, state) {
          return switch (state) {
            CurrentWeatherInitial() => _handleInitialState(context),
            CurrentWeatherLoading() => const Center(child: CircularProgressIndicator()),
            CurrentWeatherLoadingError() => const Center(child: Text("1")),
            CurrentWeatherLoaded() => _showCurrentWeather(state.currentWeather),
            _ => const Text(""),
          };
        });
  }

  Widget _handleInitialState(BuildContext context) {
    context.read<CurrentWeatherBloc>().add(FetchCurrentWeather());
    return const Center(child: CircularProgressIndicator());
  }
  Widget _showCurrentWeather(CurrentWeather currentWeather) {
    return Center(
            child: Column(
              children: [
                Text(currentWeather.city,style: TextStyle(fontSize: 35,color: Colors.white),),
                Text(" ${currentWeather.temperature}°", style: TextStyle(fontSize: 45,color: Colors.white),),
                Text(currentWeather.description, style: TextStyle(fontSize: 25,color: Colors.white),),
              ],
            ),
          );
  }
}
