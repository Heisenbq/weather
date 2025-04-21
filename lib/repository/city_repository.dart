import 'package:test_flutter_app/model/city.dart';

class CityRepository {
  List<City> getAddedCities() {
    return [
      City(name: "Moscow", country: "Russia", assetIcon: "10d"),
      City(name: "London", country: "England", assetIcon: "11d"),
      City(name: "New York", country: "USA", assetIcon: "12d"),
    ];
  }
}