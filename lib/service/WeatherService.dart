import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import '../models/Weather.dart';

class WeatherService {
  static const baseURL = "https://api.openweathermap.org/data/2.5/weather";
  final String apiKey;

  WeatherService(this.apiKey);

  Future<Weather> getWeatherByCity(String city, String unit) async {
    String url = "$baseURL?q=$city&appid=$apiKey&units=$unit";
    final res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      return Weather.fromJson(jsonDecode(res.body));
    } else {
      throw Exception("Failed to load weather data for $city");
    }
  }

  Future<Weather> getWeatherByZip(String zip, String unit) async {
    String url = "$baseURL?zip=$zip,TH&appid=$apiKey&units=$unit";
    final res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      return Weather.fromJson(jsonDecode(res.body));
    } else {
      throw Exception("Failed to load weather data for $zip");
    }
  }

  Future<List<double>> getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.deniedForever) {
      throw Exception("Location permissions are permanently denied.");
    }
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    return [position.latitude, position.longitude];
  }
}
