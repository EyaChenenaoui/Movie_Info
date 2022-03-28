import 'dart:convert';
import 'package:http/http.dart';
class Movie{
  int?id;
  List?actors;
  Movie({required this.id});
  Future<void>loadmovieactors()async {
    Response response = await get(Uri.parse('https://api.themoviedb.org/3/movie/$id/credits?api_key=c76aa0251cd073cf305fe2c0a51a4fd8')) as Response;
    Map data = jsonDecode(response.body);
      actors=data['rsults'];
  }
}