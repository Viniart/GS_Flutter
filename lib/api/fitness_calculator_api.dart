import 'dart:convert';

import 'package:gs_2/models/daily_calorie.dart';

import 'package:http/http.dart' as http;

class FitnessCalculatorApi {
  final String baseUrl = 'https://fitness-calculator.p.rapidapi.com/';
  final String key = '';
  final String host = 'fitness-calculator.p.rapidapi.com';

  //6 criem o metodo abaixo para fazer a requisição e retornar um DailyCalorie
  // Future<DailyCalorie> getDailyCalories ({...}) {}
  Future<DailyCalorie?> findDailyCalories(
    String age,
    String gender,
    String weight,
    String height,
    String activityLevel,
  ) async {
    final url = '${baseUrl}dailycalorie?age=$age&gender=$gender&weight=$weight&height=$height&activitylevel=$activityLevel';
    var response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'X-RapidAPI-Key': key,
        'X-RapidAPI-Host': host
      },
    );

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
     
      var dailyCalorie = DailyCalorie.fromJson(json['data']);

      return dailyCalorie;
    } else {
      return null;
    }
  }
}
