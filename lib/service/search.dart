import 'dart:convert';
import 'package:fify/models/item_model.dart';
import 'package:http/http.dart' as http;

class BackendService {
  static Future<List> getSuggestions(String query) async {
    if (query.isEmpty) {
      return []; // Boş liste döndür
    }

    final response = await http.get(
      Uri.parse(
          "https://api.themoviedb.org/3/search/movie?api_key=4b93d35d5c2089b7716defdd6d32c769&query=$query&page=1&include_adult=false"),
    );

    if (response.statusCode == 200) {
      ItemModel model = ItemModel.fromJson(json.decode(response.body));
      return model.results; // API'den dönen sonuçları geri döndür
    } else {
      return []; // API isteği başarısızsa boş liste döndür
    }
  }
}
