import 'dart:convert';
import 'package:http/http.dart' as http;

class Data {
  final String country;
  Data(this.country);

  Future getData() async {
    http.Response response;
    if (country == "Hong Kong") {
      response = await http.get("https://corona-stats.online/HK?format=json");
    }
    if (country == "South Korea") {
      response = await http.get("https://corona-stats.online/KR?format=json");
    }
    if (country == "United Arab Emirates") {
      response = await http.get("https://corona-stats.online/AE?format=json");
    }
    if (country == "United Kingdom") {
      response = await http.get("https://corona-stats.online/UK?format=json");
    }
    if (country == "United States") {
      response = await http.get("https://corona-stats.online/US?format=json");
    } else {
      response =
          await http.get("https://corona-stats.online/$country?format=json");
    }
    if (response.statusCode == 200) {
      String data = response.body;
      var decodedData = jsonDecode(data);
      return decodedData;
    }
  }
}
