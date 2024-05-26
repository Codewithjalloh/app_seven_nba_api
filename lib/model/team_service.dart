import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/team.dart';

class TeamService {
  static const String apiKey =
      "ENTER YOUR API KEY"; // API key (should be secured)
  static const String apiUrl =
      "https://api.balldontlie.io/v1/teams"; // API endpoint

  static Future<List<Team>> getTeams() async {
    var url = Uri.parse(apiUrl);
    var headers = {
      "Authorization":
          apiKey, // API key included in headers (check if required by the API).
    };

    var response =
        await http.get(url, headers: headers); // Making the HTTP GET request
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body); // Decoding the JSON response
      List<Team> teams = [];
      for (var eachTeam in jsonData["data"]) {
        final team = Team.fromJson(eachTeam);
        teams.add(team); // Adding the team to the list
      }
      return teams;
    } else {
      throw Exception('Failed to load teams');
    }
  }
}
