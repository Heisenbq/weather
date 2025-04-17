import 'package:test_flutter_app/model/daily_forecast.dart';

class DailyForecastRepository {
  Future<List<DailyForecast>> getDailyForecast() async {
    await Future.delayed(Duration(milliseconds: 5000));
    return [
      // DailyForecast(day: 'Today', lowestTemperature: '16°', highestTemperature: '32°'),
      // DailyForecast(day: 'Thu', lowestTemperature: '19°', highestTemperature: '31°'),
      // DailyForecast(day: 'Fri', lowestTemperature: '17°', highestTemperature: '30°'),
      // DailyForecast(day: 'Sat', lowestTemperature: '16°', highestTemperature: '27°'),
      // DailyForecast(day: 'Sun', lowestTemperature: '11°', highestTemperature: '20°'),
      // DailyForecast(day: 'Mon', lowestTemperature: '11°', highestTemperature: '20°'),
      // DailyForecast(day: 'Tue', lowestTemperature: '11°', highestTemperature: '20°'),
      // DailyForecast(day: 'Wed', lowestTemperature: '11°', highestTemperature: '20°'),
      // DailyForecast(day: 'Thu', lowestTemperature: '11°', highestTemperature: '20°'),
      // DailyForecast(day: 'Fri', lowestTemperature: '11°', highestTemperature: '20°'),
    ];
}
}