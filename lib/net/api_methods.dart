import "package:http/http.dart" as http;
import "dart:convert";

Future<double> getPrice(String id) async {
  Uri url = Uri.parse("https://api.coingecko.com/api/v3/coins/$id");
  try {
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonRes = json.decode(response.body);
      var value = jsonRes["market_data"]["current_price"]["inr"].toString();
      return double.parse(value);
    } else {
      throw Exception("Failed to load");
    }
  } catch (e) {
    print(e.toString());
    return 0.0;
  }
}
