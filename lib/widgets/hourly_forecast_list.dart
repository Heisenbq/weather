import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/hourly_forecast_bloc/hourly_forecast_bloc.dart';

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
                return _HourlyForecastItem(
                  time: item.time,
                  temperature: "${item.temperature}°",
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


class _HourlyForecastItem extends StatelessWidget {
  final String time;
  final String temperature;
  final Widget icon;

  const _HourlyForecastItem({
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

