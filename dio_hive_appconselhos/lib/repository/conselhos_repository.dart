import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio_hive_appconselhos/models/conselhos_model.dart';

class ConselhoRepository {
  final dio = Dio();
  final url = 'https://api.adviceslip.com/advice';
  Future<Conselhos> getConselho() async {
    var response = await dio.get(url);
    var json = jsonDecode(response.data);
    var conselho = Conselhos.fromJson(json);
    return conselho;
  }
}
