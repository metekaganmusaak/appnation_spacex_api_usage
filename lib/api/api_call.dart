import 'dart:convert';
import 'package:appnation_spacex/model/spacex_model.dart';
import 'package:http/http.dart' as http;

class ApiCall {
  Future<SpaceX> apiCall() async {
    final Uri apiURL = Uri.parse('https://api.spacexdata.com/v4/launches/latest');
    final response = await http.get(apiURL);

    if (response.statusCode == 200) {
      return SpaceX.fromJson(json.decode(response.body));
    } else if (response.statusCode == 400) {
      throw Exception("Bad Request");
    } else {
      throw Exception('Something went wrong');
    }

  }


}
