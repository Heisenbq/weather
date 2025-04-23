import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_app/model/hourly_forecast.dart';

import '../../../blocs/hourly_forecast_bloc/hourly_forecast_bloc.dart';

class HourlyForecastList extends StatefulWidget {
  final String city;
  const HourlyForecastList({required this.city, super.key});

  @override
  State<HourlyForecastList> createState() => _HourlyForecastListState();
}

class _HourlyForecastListState extends State<HourlyForecastList> {

  @override
  void initState() {
    super.initState();
    context.read<HourlyForecastBloc>().add(FetchHourlyForecast(widget.city));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HourlyForecastBloc, HourlyForecastState>(
        builder: (context, state) {
          return switch (state) {
            HourlyForecastInitial() => const Center(child: CircularProgressIndicator()),
            HourlyForecastLoading() => const Center(child: CircularProgressIndicator()),
            HourlyForecastLoadingError() => const Center(child: Text("ERROR OCCURRED")),
            HourlyForecastLoaded() => _buildForecastList(state.forecast),
            _ => const SizedBox.shrink(),
          };
        }
    );
  }

  Widget _buildForecastList(List<HourlyForecast> forecast) {
      return SizedBox(
        height: 105,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: forecast.length,
          itemBuilder: (context, index) {
            final item = forecast[index];
            return _HourlyForecastItem(
              time: item.time,
              temperature: "${item.temperature}°",
              icon: item.getIcon(size: 50),
            );
          },
        ),
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

