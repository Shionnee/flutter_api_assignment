import 'package:flutter_api_assignment/models/dogbreeds_model.dart';
import 'package:flutter_api_assignment/network/dog_api_endpoints.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DogNetwork {
  Future<DogBreedsModel> getBreeds() async {
    try {
      final response = await http
          .get(Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.getAllBreedsList));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        // Return a DogBreeds object with only breed names
        return DogBreedsModel.fromJson(data);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Error fetching dog breeds: $e');
    }
  }

  Future<String> getRandomImagebyBreed(String breed) async {
    final String apiUrl =
        "${ApiEndPoints.baseUrl}/breed/${breed}/images/random";
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return data['message'];
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Error fetching dog by breed: $e');
    }
  }
}
