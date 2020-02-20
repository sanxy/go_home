import 'dart:convert';
import 'package:http/http.dart' as http;
import '../classes/message.dart';

class MessageServices {

  final String id;

  MessageServices({this.id});

  static const String url = "https://www.gohome.ng/get_message.php?receiver_id";

  static Future<List<Message>> getMessages() async{
    try {
      final response =await http.get(url);
      if(response.statusCode == 200){
        List<Message> list = parseMessages(response.body);
        return list;
      }else{
        throw Exception("Error");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static List<Message> parseMessages(String responseBody){
    final parsed =json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Message>((json) => Message.fromJson(json)).toList();
  }
}