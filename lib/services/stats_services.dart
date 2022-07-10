// ignore_for_file: unnecessary_string_escapes, camel_case_types

import 'dart:convert';

import 'package:covid_tracker/Model/Covidrecord.dart';
import 'package:covid_tracker/services/utils/app_url.dart';
import 'package:http/http.dart' as http;

class stats_services {
  Future<Covidrecord> fetchstats() async {
    final response = await http.get(Uri.parse(app_url.world_stats_api));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return Covidrecord.fromJson(data);
    } else {
      throw Exception('Error');
    }
  }

  Future<List<dynamic>> coutrieslisapi() async {
    // ignore: prefer_typing_uninitialized_variables
    var data;
    final response = await http.get(Uri.parse(app_url.countriesurl));
    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Error');
    }
  }
}
