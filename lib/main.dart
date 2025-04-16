import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_app/repository/hourly_forecast_repository.dart';
import 'package:test_flutter_app/weather_bloc/weather_bloc.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeatherBloc(HourlyForecastRepository()),
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
              const CurrentWeather(
                location: 'Krasnodar',
                temperature: ' 31°',
                condition: 'Mostly Sunny',
              ),
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

class CurrentWeather extends StatelessWidget {
  final String location;
  final String temperature;
  final String condition;

  const CurrentWeather({
    super.key,
    required this.location,
    required this.temperature,
    required this.condition,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            location,
            style: const TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
          Text(
            temperature,
            style: const TextStyle(
              fontSize: 60,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
          Text(condition, style: TextStyle(fontSize: 20, color: Colors.white)),
        ],
      ),
    );
  }
}

class HourlyForecastList extends StatelessWidget {
  const HourlyForecastList({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        if (state is WeatherInitial) {
          context.read<WeatherBloc>().add(FetchHourlyForecast());
          return const Center(child: CircularProgressIndicator());
        }

        if (state is WeatherLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is WeatherLoadingError) {
          return Center(child: Text("ERROR OCURED"));
        }

        if (state is WeatherLoaded) {
          return SizedBox(
            height: 90,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: state.forecast.length,
              itemBuilder: (context, index) {
                final item = state.forecast[index];
                return HourlyForecastItem(
                  time: item.time,
                  temperature: item.temperature,
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

  const HourlyForecastItem({
    super.key,
    required this.time,
    required this.temperature,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        children: [
          Text(
            time,
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8),
          Icon(Icons.wb_sunny, color: Colors.yellow),
          SizedBox(height: 8),
          Text(
            temperature,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class DailyForecastList extends StatelessWidget {
  static const List<Map<String, String>> _forecasts = [
    {'day': 'Today', 'low': '16°', 'high': '32°'},
    {'day': 'Thu', 'low': '19°', 'high': '31°'},
    {'day': 'Fri', 'low': '17°', 'high': '30°'},
    {'day': 'Sat', 'low': '16°', 'high': '27°'},
    {'day': 'Sun', 'low': '11°', 'high': '20°'},
    {'day': 'Mon', 'low': '11°', 'high': '20°'},
    {'day': 'Tue', 'low': '11°', 'high': '20°'},
    {'day': 'Wed', 'low': '11°', 'high': '20°'},
    {'day': 'Thu', 'low': '11°', 'high': '20°'},
    {'day': 'Fri', 'low': '11°', 'high': '20°'},
  ];

  const DailyForecastList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          '10-DAY FORECAST',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.blue,
          ),
        ),
        Expanded(
          child: ListView.separated(
            physics: const ClampingScrollPhysics(),
            itemCount: _forecasts.length,
            itemBuilder: (context, index) {
              return DailyForecastItem(
                day: _forecasts[index]['day']!,
                low: _forecasts[index]['low']!,
                high: _forecasts[index]['high']!,
              );
            },
            separatorBuilder: (context, index) {
              return const Divider(thickness: 1, color: Colors.grey);
            },
          ),
        ),
      ],
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
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
