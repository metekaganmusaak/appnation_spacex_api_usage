import 'dart:convert';

import 'package:appnation_spacex/model/spacex_model.dart';
import 'package:http/http.dart' as http;

class ApiCall {
  
  static Future<SpaceX> apiCall() async {
    final response = await http.get(Uri.parse('https://api.spacexdata.com/v4/launches/latest'));

    try{
      // ignore: unrelated_type_equality_checks
      if(response == 200)
    {
      return SpaceX.fromJson(json.decode(response.body));
    }
    }catch(e){
      throw Exception(e);
    }
    return SpaceX.fromJson(json.decode(response.body));
  }
}