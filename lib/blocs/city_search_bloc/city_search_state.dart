

import '../../model/city.dart';

abstract class CitySearchState {}

class CitySearchInitial extends CitySearchState {
  final List<City> cities;

  CitySearchInitial(this.cities);
}

class CitySearchLoading extends CitySearchState {}

class CitySearchLoaded extends CitySearchState {
  final List<City> cities;

  CitySearchLoaded(this.cities);
}

class CitySearchError extends CitySearchState {
  final String message;

  CitySearchError(this.message);
}

class MinSymbols extends CitySearchState {
}

class NothingFound extends CitySearchState {}

