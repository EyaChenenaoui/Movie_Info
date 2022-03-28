import 'dart:convert';

import 'package:http/http.dart';

class help {
  int? id;
  String? imdbid;
  help({required this.id });
  Future<void> getimdbid() async {
    Response response = await get(Uri.parse(
        'https://api.themoviedb.org/3/movie/${this.id}?api_key=c76aa0251cd073cf305fe2c0a51a4fd8')) as Response;
    Map data = await jsonDecode(response.body);
    imdbid = data['imdb_id'];
  }
}