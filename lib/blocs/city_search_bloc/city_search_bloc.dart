import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repository/city_repository.dart';
import 'city_search_event.dart';
import 'city_search_state.dart';

class CitySearchBloc extends Bloc<CitySearchEvent, CitySearchState> {
  final CityRepository repository;

  CitySearchBloc(this.repository) : super(CitySearchInitial()) {
    on<CityTextChanged>((event, emit) async {
      if (event.text.isEmpty) {
        emit(CitySearchInitial());
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
      emit(CitySearchInitial());
    });


  }
}
