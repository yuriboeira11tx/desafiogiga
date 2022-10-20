import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';

class APIRepository {
  // chamada na API
  Future<dynamic> callApi({String? filter, int? page}) async {
    var client = http.Client();

    // tratamento de filtro
    String url = "";
    if (filter != null && filter != "all") {
      url =
          "https://randomuser.me/api/?page=$page&gender=$filter&results=20&nat=br";
    } else {
      url =
          "https://randomuser.me/api/?page=$page&gender=$filter&results=20&nat=br";
    }

    try {
      var response = await client.get(Uri.parse(url));
      var decodedJson = json.decode(response.body);
      return decodedJson["results"];
    } on HttpException catch (error) {
      return error;
    } on SocketException catch (error) {
      return SocketException(error.message);
    } finally {
      client.close();
    }
  }
}
