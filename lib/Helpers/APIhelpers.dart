import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/Covid19Modelclass.dart';


class APIHelper{
  APIHelper._();
  static final APIHelper apiHelper =  APIHelper._();

  Future<WorldWideData?> getCovidData() async {

    Uri api =  Uri.parse("https://api.covid19api.com/summary");
    http.Response response = await http.get(api);
    if(response.statusCode == 200)
    {
      Map<String, dynamic> data = await jsonDecode(response.body);
      WorldWideData worldWideData = WorldWideData.fromJSON(data);
      worldWideData.countries = worldWideData.countries.map((e) => Country.fromJSON(e)).toList();
      return worldWideData;
    }
    return null;
  }
}
