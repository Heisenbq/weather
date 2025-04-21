import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/daily_forecast_bloc/daily_forecast_bloc.dart';
import '../model/daily_forecast.dart';

class DailyForecastList extends StatelessWidget {
  const DailyForecastList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DailyForecastBloc, DailyForecastState>(
      builder: (context, state) {
        return switch (state) {
          DailyForecastInitial() => _handleInitialState(context),
          DailyForecastLoading() => const Center(
            child: CircularProgressIndicator(),
          ),
          DailyForecastLoadingError() => const Center(
            child: Text("ERROR OCCURRED"),
          ),
          DailyForecastLoaded() => _buildForecastList(state.forecast),
          _ => const SizedBox.shrink(),
        };
      },
    );
  }

  Widget _handleInitialState(BuildContext context) {
    context.read<DailyForecastBloc>().add(FetchDailyForecast());
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildForecastList(List<DailyForecast> forecast) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            physics: const ClampingScrollPhysics(),
            itemCount: forecast.length,
            itemBuilder: (context, index) {
              final item = forecast[index];
              return _DailyForecastItem(
                day: item.day,
                low: item.lowestTemperature.toString(),
                high: item.highestTemperature.toString(),
                icon: item.getIcon(size: 30),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _DailyForecastItem extends StatelessWidget {
  final String day;
  final String low;
  final String high;
  final Widget icon;

  const _DailyForecastItem({
    required this.day,
    required this.low,
    required this.high,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    day,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(),
              ],
            ),
          ),
          Expanded(flex: 1, child: icon),

          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "$low°",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
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
                  "$high°",
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
