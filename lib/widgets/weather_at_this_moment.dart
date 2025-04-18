import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/current_weather_bloc/current_weather_bloc.dart';

class WeatherAtThisMoment extends StatelessWidget {

  const WeatherAtThisMoment({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentWeatherBloc, CurrentWeatherState>(
        builder: (context, state) {
          if (state is CurrentWeatherInitial) {
            context.read<CurrentWeatherBloc>().add(FetchCurrentWeather());

            return const Center(child: CircularProgressIndicator());
          }
          if (state is CurrentWeatherLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is CurrentWeatherLoadingError) {
            return Center(child: Text("1"));
          }
          if (state is CurrentWeatherLoaded) {
            return Center(
              child: Column(
                children: [
                  Text(state.currentWeather.city,style: TextStyle(fontSize: 35,color: Colors.white),),
                  Text(" " + state.currentWeather.temperature.toString()+"°", style: TextStyle(fontSize: 45,color: Colors.white),),
                  Text(state.currentWeather.description, style: TextStyle(fontSize: 25,color: Colors.white),),
                ],
              ),
            );
          }
          return Text("");
        });
  }
}
