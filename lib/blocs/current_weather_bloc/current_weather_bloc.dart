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
        // final position = await LocationService.getCurrentPosition();
        // final city = await LocationService.getCityName(
        //   position.latitude,
        //   position.longitude,
        // );
        // final currentWeather = await currentWeatherRepository.getCurrentWeather(city);
        final currentWeather = await currentWeatherRepository.getCurrentWeather(event.city);
        emit(CurrentWeatherLoaded(currentWeather));
      }catch (e){
        emit(CurrentWeatherLoadingError(e.toString()));
      }
    });
  }
}
