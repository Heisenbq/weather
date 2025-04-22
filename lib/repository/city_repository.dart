import 'package:dio/dio.dart';
import 'package:test_flutter_app/api_actions/weather_api.dart';
import '../model/city.dart';


class CityRepository {
  final WeatherApi weatherApi;

  List<City> cities = [
    City(name: "Moscow", country: "Russia",favorite: false),
    City(name: "London", country: "England",favorite: false),
  ];

  CityRepository(this.weatherApi);

  Future<List<City>> searchCities(String query) async {
    return await weatherApi.searchCities(query);
  }

  List<City> getAddedCities() {
    cities.sort();
    return cities;
  }

  void addCity(City city) {
    if (cities.contains(city)) return;
    cities.add(city);
  }

}
