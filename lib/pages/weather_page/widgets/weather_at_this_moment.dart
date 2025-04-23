import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_app/model/current_weather.dart';

import '../../../blocs/current_weather_bloc/current_weather_bloc.dart';

class WeatherAtThisMoment extends StatefulWidget {
  final String city;

  const WeatherAtThisMoment({
    required this.city,
    super.key,
  });

  @override
  State<WeatherAtThisMoment> createState() => _WeatherAtThisMomentState();
}

class _WeatherAtThisMomentState extends State<WeatherAtThisMoment> {

  @override
  void initState() {
    super.initState();
    context.read<CurrentWeatherBloc>().add(FetchCurrentWeather(widget.city));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentWeatherBloc, CurrentWeatherState>(
        builder: (context, state) {
          return switch (state) {
            CurrentWeatherInitial() => const Center(child: CircularProgressIndicator()),
            CurrentWeatherLoading() => const Center(child: CircularProgressIndicator()),
            CurrentWeatherLoadingError() => const Center(child: Text("1")),
            CurrentWeatherLoaded() => _showCurrentWeather(state.currentWeather),
            _ => const Text(""),
          };
        });
  }

  Widget _showCurrentWeather(CurrentWeather currentWeather) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: Center(child: Text(currentWeather.city,style: TextStyle(fontSize: 35,color: Colors.white),))),
          ],
        ),
        Row(
          children: [
            Expanded(child: Center(child: Text(" ${currentWeather.temperature}°", style: TextStyle(fontSize: 45,color: Colors.white),))),
          ],
        ),
        Row(
          children: [
            Expanded(child: Center(child: Text(currentWeather.description, style: TextStyle(fontSize: 25,color: Colors.white),))),
          ],
        ),
      ],
    );
  }
}
