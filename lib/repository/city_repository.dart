import 'package:dio/dio.dart';
import 'package:test_flutter_app/api_actions/weather_api.dart';
import '../model/city.dart';

class CityRepository {
  final WeatherApi weatherApi;

  List<City> cities = [
    City(name: "Moscow", country: "Russia"),
    City(name: "London", country: "England"),
  ];

  CityRepository(this.weatherApi);

  Future<List<City>> searchCities(String query) async {
    return await weatherApi.searchCities(query);
  }

  List<City> getAddedCities() {
    return cities;
  }

  void addCity(City city) {
    cities.add(city);
  }
}
