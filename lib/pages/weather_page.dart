import 'package:flutter/material.dart';

import '../widgets/daily_forecast_list.dart';
import '../widgets/hourly_forecast_list.dart';
import '../widgets/weather_at_this_moment.dart';

class WeatherPage extends StatefulWidget {
  final String city;

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
              Color(0xFF0B3D91), // глубокий индиго (верх)
              Color(0xFF0D47A1), // тёмно-синий
              Color(0xFF1565C0), // насыщенный синий
              Color(0xFF1976D2), // ярко-синий
              Color(0xFF1E88E5), // переход к небесному
              Color(0xFF42A5F5), // нежно-голубой
              Color(0xFF64B5F6), // ещё светлее
              Color(0xFF90CAF9), // почти как утреннее небо
            ],
            stops: [
              0.0,   // верхний (0%)
              0.05,  // 10%
              0.15,  // 25%
              0.25,  // 40%
              0.50,  // 55%
              0.70,  // 70%
              0.85,  // 85%
              1.0,  // 93%// низ (100%)
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 75),
                WeatherAtThisMoment(city: widget.city),
                const SizedBox(height: 24),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  decoration: BoxDecoration(
                    color: Color(0xFF2270BB),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: HourlyForecastList(city: widget.city),
                ),
                const SizedBox(height: 32),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    decoration: BoxDecoration(
                      color: Color(0xFF2270BB),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: DailyForecastList(city: widget.city),
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back, size: 40),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}
