import 'dart:convert';
import 'package:manajemenpariwisata/helpers/api.dart';
import 'package:manajemenpariwisata/helpers/api_url.dart';
import 'package:manajemenpariwisata/models/ulasan.dart';

class UlasanBloc {
  // Fetching all reviews (Ulasan)
  static Future<List<Ulasan>> getUlasans() async {
    String apiUrl = ApiUrl.listUlasan;
    var response = await Api().get(apiUrl);
    var jsonObj = json.decode(response.body);
    List<dynamic> listUlasan = (jsonObj as Map<String, dynamic>)['data'];
    List<Ulasan> ulasans = [];
    for (int i = 0; i < listUlasan.length; i++) {
      ulasans.add(Ulasan.fromJson(listUlasan[i]));
    }
    return ulasans;
  }

  // Adding a new review (Ulasan)
  static Future addUlasan({Ulasan? ulasan}) async {
    String apiUrl = ApiUrl.createUlasan;
    var body = {
      "reviewer": ulasan!.reviewer,
      "rating": ulasan.rating.toString(),
      "comments": ulasan.comments,
    };
    var response = await Api().post(apiUrl, body);
    var jsonObj = json.decode(response.body);
    return jsonObj['status'];
  }

  // Updating an existing review (Ulasan)
  static Future updateUlasan({required Ulasan ulasan}) async {
    String apiUrl = ApiUrl.updateUlasan((ulasan.id!));
    var body = {
      "reviewer": ulasan.reviewer,
      "rating": ulasan.rating.toString(),
      "comments": ulasan.comments,
    };
    var response = await Api().put(apiUrl, jsonEncode(body));
    var jsonObj = json.decode(response.body);
    return jsonObj['status'];
  }

  // Deleting a review (Ulasan)
  static Future<bool> deleteUlasan({required int id}) async {
    String apiUrl = ApiUrl.deleteUlasan(id);
    var response = await Api().delete(apiUrl);
    var jsonObj = json.decode(response.body);
    return (jsonObj as Map<String, dynamic>)['status'];
  }
}
