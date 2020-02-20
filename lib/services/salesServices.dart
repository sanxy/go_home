import 'dart:convert';
import 'package:http/http.dart' as http;
import '../classes/property.dart';

class SalesServices {
  static const String url = "http://www.gohome.ng/fetch_selected.php?status='Sale'";

  static Future<List<Property>> getProperties() async{
    try {
      final response =await http.get(url);
      if(response.statusCode == 200){
        List<Property> list = parseProperties(response.body);
        return list;
      }else{
        throw Exception("Error");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static List<Property> parseProperties(String responseBody){
    final parsed =json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Property>((json) => Property.fromJson(json)).toList();
  }
}