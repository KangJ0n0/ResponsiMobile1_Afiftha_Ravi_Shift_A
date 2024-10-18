import 'dart:convert';
import 'package:manajemenpariwisata/helpers/api.dart';
import 'package:manajemenpariwisata/helpers/api_url.dart';
import 'package:manajemenpariwisata/models/ulasan.dart';

class UlasanBloc {
  // Fetching all reviews (Ulasan)
  static Future<List<Ulasan>> getUlasans() async {
    String apiUrl = ApiUrl.listUlasan;
    var response = await Api().get(apiUrl);

    if (response.statusCode == 200) { // Check if the response is successful
      var jsonObj = json.decode(response.body);
      List<dynamic> listUlasan = (jsonObj as Map<String, dynamic>)['data'];
      List<Ulasan> ulasans = [];
      for (var item in listUlasan) { // Using for-in loop for better readability
        ulasans.add(Ulasan.fromJson(item));
      }
      return ulasans;
    } else {
      throw Exception('Failed to load ulasans'); // Handle errors
    }
  }

  // Adding a new review (Ulasan)
  static Future<bool> addUlasan({required Ulasan ulasan}) async {
    String apiUrl = ApiUrl.createUlasan;
    var body = {
      "reviewer": ulasan.reviewer,
      "rating": ulasan.rating,
      "comments": ulasan.comments,
    };

    var response = await Api().post(apiUrl, body);
    var jsonObj = json.decode(response.body);
    return jsonObj['status'] == true; // Assuming the status is a boolean
  }

  // Updating an existing review (Ulasan)
  static Future<bool> updateUlasan({required Ulasan ulasan}) async {
    String apiUrl = ApiUrl.updateUlasan(ulasan.id!);
    var body = {
      "reviewer": ulasan.reviewer,
      "rating": ulasan.rating,
      "comments": ulasan.comments,
    };

    var response = await Api().put(apiUrl, jsonEncode(body));
    var jsonObj = json.decode(response.body);
    return jsonObj['status'] == true; // Assuming the status is a boolean
  }

  // Deleting a review (Ulasan)
  static Future<bool> deleteUlasan({required int id}) async {
    String apiUrl = ApiUrl.deleteUlasan(id);
    var response = await Api().delete(apiUrl);
    var jsonObj = json.decode(response.body);
    return jsonObj['status'] == true; // Assuming the status is a boolean
  }
}
