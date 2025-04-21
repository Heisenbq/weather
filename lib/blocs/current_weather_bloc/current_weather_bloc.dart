import 'package:bloc/bloc.dart';
import 'package:test_flutter_app/model/current_weather.dart';

import '../../repository/weather_repository.dart';
import '../../service/location_service.dart';

part 'current_weather_event.dart';
part 'current_weather_state.dart';

class CurrentWeatherBloc extends Bloc<CurrentWeatherEvent, CurrentWeatherState> {
  final WeatherRepository currentWeatherRepository;

  CurrentWeatherBloc(this.currentWeatherRepository) : super(CurrentWeatherInitial()) {
    on<FetchCurrentWeather>((event, emit) async {
      emit(CurrentWeatherLoading());
      try{
        CurrentWeather currentWeather;
        if (event.city != null) {
          currentWeather = await currentWeatherRepository.getCurrentWeather(event.city!);
        }
        else {
          final position = await LocationService.getCurrentPosition();
          currentWeather = await currentWeatherRepository.getCurrentWeatherByCoordinates(position.latitude,position.longitude);
        }
        emit(CurrentWeatherLoaded(currentWeather));
      }catch (e){
        emit(CurrentWeatherLoadingError(e.toString()));
      }
    });
  }
}
