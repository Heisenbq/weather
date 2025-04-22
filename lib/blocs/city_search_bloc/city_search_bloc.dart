import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repository/city_repository.dart';
import 'city_search_event.dart';
import 'city_search_state.dart';

class CitySearchBloc extends Bloc<CitySearchEvent, CitySearchState> {
  final CityRepository repository;

  CitySearchBloc(this.repository) : super(CitySearchInitial(repository.getAddedCities())) {
    on<CityTextChanged>((event, emit) async {
      if (event.text.isEmpty) {
        emit(CitySearchInitial(repository.getAddedCities()));
        return;
      }
      if (event.text.length < 3) {
        emit(MinSymbols());
        return;
      }

      emit(CitySearchLoading());

      try {
        final cities = await repository.searchCities(event.text);
        emit(CitySearchLoaded(cities));
      } catch (e) {
        emit(CitySearchError("Ошибка при загрузке"));
      }
    });

    on<AddCity>((event, emit) async {
      repository.addCity(event.city);
      emit(CitySearchInitial(repository.getAddedCities()));
    });


  }
}
