import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import '../../models/weather_model.dart';

part 'weather_bloc_event.dart';
part 'weather_bloc_state.dart';

class WeatherBlocBloc extends Bloc<WeatherBlocEvent, WeatherBlocState> {
  WeatherBlocBloc() : super(WeatherBlocInitial()) {
    on<FetchWeather>((event, emit) async {
      emit(WeatherBlocLoading());
      try {
        final apiKey = dotenv.env['WEATHER_API_KEY'] ?? '';

        final url = Uri.parse(
          'https://api.weatherapi.com/v1/forecast.json?key=$apiKey&q=${event.position.latitude},${event.position.longitude}&days=1&aqi=no&alerts=no',
        );

        final response = await http.get(url);

        if (response.statusCode == 200) {
          final Map<String, dynamic> data = jsonDecode(response.body);

          final weatherModel = WeatherModel.fromJson(data);

          emit(WeatherBlocSuccess(weatherModel));
        } else {
          emit(WeatherBlocFailure());
        }
      } catch (e) {
        emit(WeatherBlocFailure());
      }
    });
  }
}
