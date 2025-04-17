import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_app/blocs/current_weather_bloc/current_weather_bloc.dart';
import 'package:test_flutter_app/blocs/hourly_forecast_bloc/hourly_forecast_bloc.dart';
import 'package:test_flutter_app/repository/current_weather_repository.dart';
import 'package:test_flutter_app/repository/daily_forecast_repository.dart';
import 'package:test_flutter_app/repository/hourly_forecast_repository.dart';

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
          create: (context) => HourlyForecastBloc(HourlyForecastRepository()),
        ),
        BlocProvider<DailyForecastBloc>(
          create: (context) => DailyForecastBloc(DailyForecastRepository()),
        ),
        BlocProvider<CurrentWeatherBloc>(
          create: (context) => CurrentWeatherBloc(CurrentWeatherRepository()),
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
      backgroundColor: Color(0xFF5480AD),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 75),
              NowWeather(),
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
    );
  }
}

class NowWeather extends StatelessWidget {

  const NowWeather({
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

class DailyForecastList extends StatelessWidget {
  const DailyForecastList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DailyForecastBloc, DailyForecastState>(
      builder: (context, state) {
        if (state is DailyForecastInitial) {
          context.read<DailyForecastBloc>().add(FetchDailyForecast());
          return const Center(child: CircularProgressIndicator());
        }

        if (state is DailyForecastLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is DailyForecastLoadingError) {
          return Center(child: Text("ERROR OCURED"));
        }

        if (state is DailyForecastLoaded) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  physics: const ClampingScrollPhysics(),
                  itemCount: state.forecast.length,
                  itemBuilder: (context, index) {
                    final item = state.forecast[index];
                    return DailyForecastItem(
                      day: item.day,
                      low: item.lowestTemperature,
                      high: item.highestTemperature,
                    );
                  },
                ),
              ),
            ],
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}

class HourlyForecastList extends StatelessWidget {
  const HourlyForecastList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HourlyForecastBloc, HourlyForecastState>(
      builder: (context, state) {
        if (state is HourlyForecastInitial) {
          context.read<HourlyForecastBloc>().add(FetchHourlyForecast());
          return const Center(child: CircularProgressIndicator());
        }

        if (state is HourlyForecastLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is HourlyForecastLoadingError) {
          return Center(child: Text("ERROR OCURED"));
        }

        if (state is HourlyForecastLoaded) {
          return SizedBox(
            height: 105,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: state.forecast.length,
              itemBuilder: (context, index) {
                final item = state.forecast[index];
                return HourlyForecastItem(
                  time: item.time,
                  temperature: item.temperature.toString()+ "°",
                  icon: item.getIcon(size: 50),
                );
              },
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}

class HourlyForecastItem extends StatelessWidget {
  final String time;
  final String temperature;
  final Widget icon;

  const HourlyForecastItem({
    super.key,
    required this.time,
    required this.temperature,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        children: [
          Text(time, style: TextStyle(fontSize: 16, color: Colors.white)),
          SizedBox(height: 0),
          icon,
          SizedBox(height: 3),
          Text(
            temperature,
            style: const TextStyle(fontSize: 18, color: Colors.white),
          ),
        ],
      ),
    );
  }
}


class DailyForecastItem extends StatelessWidget {
  final String day;
  final String low;
  final String high;

  const DailyForecastItem({
    super.key,
    required this.day,
    required this.low,
    required this.high,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: Row(
              children: [
                Text(
                  day,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 10),
              ],
            ),
          ),
          Expanded(flex: 1, child: Icon(Icons.wb_sunny, color: Colors.yellow)),

          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(low, style: TextStyle(fontSize: 18, color: Colors.white)),
                const SizedBox(width: 10),
                Expanded(
                  child: Container(
                    height: 3,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.red, Colors.amber, Colors.yellow],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  high,
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
