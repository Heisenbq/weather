import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/daily_forecast_bloc/daily_forecast_bloc.dart';

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

        return const SizedBox.shrink();
      },
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
                Text("$low°", style: TextStyle(fontSize: 18, color: Colors.white)),
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