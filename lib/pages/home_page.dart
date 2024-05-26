import 'dart:convert'; // For converting JSON data.
import 'package:flutter/material.dart'; // Flutter framework for building UI.
import 'package:http/http.dart' as http; // For making HTTP requests.
import '../model/team.dart';
import '../model/team_service.dart'; // Importing the Team model.

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
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                      ),
                      child: ListTile(
                        title: Text(teams[index].abbreviation),
                        subtitle: Text(teams[index].city),
                      ),
                    );
                  },
                ),
    );
  }
}
