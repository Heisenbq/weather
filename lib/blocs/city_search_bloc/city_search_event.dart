import 'package:test_flutter_app/model/city.dart';

abstract class CitySearchEvent {}

class CityTextChanged extends CitySearchEvent {
  final String text;

  CityTextChanged(this.text);
}

class AddCity extends CitySearchEvent {
  final City city;

  AddCity(this.city);
}

class GetCities extends CitySearchEvent {}
