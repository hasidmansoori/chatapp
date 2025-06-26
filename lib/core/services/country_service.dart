import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../models/country_model.dart';

class CountryService {
  Future<List<Country>> fetchCountries() async {
    final res = await http.get(Uri.parse('https://restcountries.com/v3.1/all?fields=name,cca2'));
    if (res.statusCode == 200) {
      final List data = json.decode(res.body);
      return data.map((c) => Country.fromJson(c)).toList();
    }
    return [];
  }
}
