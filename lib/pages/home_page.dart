import 'dart:convert'; // For converting JSON data.
import 'package:flutter/material.dart'; // Flutter framework for building UI.
import 'package:cached_network_image/cached_network_image.dart'; // For caching network images
import 'package:http/http.dart' as http; // For making HTTP requests.
import '../model/team.dart'; // Importing the Team model.
import '../model/team_service.dart';
import '../util/team_logos.dart';
import 'team_detail_page.dart'; // Importing the TeamDetailPage.

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Team> teams = [];
  bool isLoading = true; // Loading state
  String errorMessage = ''; // Error message

  @override
  void initState() {
    super.initState();
    fetchTeams(); // Fetch teams when the widget is initialized
  }

  Future<void> fetchTeams() async {
    try {
      teams = await TeamService.getTeams(); // Fetching teams from the service
      setState(() {
        isLoading = false; // Loading complete
      });
    } catch (error) {
      setState(() {
        isLoading = false;
        errorMessage = error.toString(); // Capture error
      });
    }
  }

  void _navigateToDetailPage(BuildContext context, Team team) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TeamDetailPage(team: team),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Teams'),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator()) // Show loading spinner
          : errorMessage.isNotEmpty
              ? Center(
                  child: Text('Error: $errorMessage')) // Show error message
              : ListView.builder(
                  itemCount: teams.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => _navigateToDetailPage(context, teams[index]),
                      child: Card(
                        margin: EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              CachedNetworkImage(
                                imageUrl: teamLogos[
                                        teams[index].abbreviation] ??
                                    'https://via.placeholder.com/40', // Placeholder if logo not found
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                                width: 40,
                                height: 40,
                              ),
                              SizedBox(width: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    teams[index].fullName,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '${teams[index].city} (${teams[index].abbreviation})',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
