import 'package:dio/dio.dart';

Future<Map> getData() async{
  var response =
      await Dio().get("https://api.hgbrasil.com/weather?key=f6100a1f&woeid=455823");

  return response.data;
}
