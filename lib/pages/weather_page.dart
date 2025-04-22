import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/city_search_bloc/city_search_bloc.dart';
import '../blocs/city_search_bloc/city_search_event.dart';
import '../model/city.dart';
import '../widgets/daily_forecast_list.dart';
import '../widgets/hourly_forecast_list.dart';
import '../widgets/weather_at_this_moment.dart';

class WeatherPage extends StatefulWidget {
  final City city;

  const WeatherPage({super.key, required this.city});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF0B3D91),
              Color(0xFF0D47A1),
              Color(0xFF1565C0),
              Color(0xFF1976D2),
              Color(0xFF1E88E5),
              Color(0xFF42A5F5),
              Color(0xFF64B5F6),
              Color(0xFF90CAF9),
            ],
            stops: [0.0, 0.05, 0.15, 0.25, 0.50, 0.70, 0.85, 1.0],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 75),
                WeatherAtThisMoment(city: widget.city.name),
                const SizedBox(height: 24),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  decoration: BoxDecoration(
                    color: Color(0xFF2270BB),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: HourlyForecastList(city: widget.city.name),
                ),
                const SizedBox(height: 32),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    decoration: BoxDecoration(
                      color: Color(0xFF2270BB),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: DailyForecastList(city: widget.city.name),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Color(0xFF2270BB),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                context.read<CitySearchBloc>().add(ToggleCityFavorite(widget.city));
                setState(() {

                });
              },
              icon:
                  widget.city.favorite
                      ? Icon(Icons.star, color: Colors.yellow, size: 40)
                      : Icon(Icons.star_border, color: Colors.white, size: 40),
            ),
            IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white, size: 40),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}
