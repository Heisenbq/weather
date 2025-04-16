import 'package:bloc/bloc.dart';
import 'package:test_flutter_app/api_actions/weather_api.dart';
import 'package:test_flutter_app/model/current_weather.dart';
import 'package:test_flutter_app/repository/current_weather_repository.dart';

part 'current_weather_event.dart';
part 'current_weather_state.dart';

class CurrentWeatherBloc extends Bloc<CurrentWeatherEvent, CurrentWeatherState> {
  final CurrentWeatherRepository currentWeatherRepository;

  CurrentWeatherBloc(this.currentWeatherRepository) : super(CurrentWeatherInitial()) {
    on<FetchCurrentWeather>((event, emit) async {
      emit(CurrentWeatherLoading());
      try{
        // final currentWeather = await currentWeatherRepository.getCurrentWeather();
        final currentWeather = await WeatherApi().fetchWeatherByCity("Honolulu");
        emit(CurrentWeatherLoaded(currentWeather));
      }catch (e){
        emit(CurrentWeatherLoadingError(e.toString()));
      }
    });
  }
}
