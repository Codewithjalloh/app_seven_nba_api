import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart'; // For caching network images
import '../model/team.dart';
import '../util/team_logos.dart'; // Import the Team model

class TeamDetailPage extends StatelessWidget {
  final Team team;

  TeamDetailPage({required this.team});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(team.fullName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CachedNetworkImage(
                imageUrl: teamLogos[team.abbreviation] ??
                    'https://via.placeholder.com/100', // Placeholder if logo not found
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
                width: 100,
                height: 100,
              ),
            ),
            SizedBox(height: 24),
            Text(
              'Full Name: ${team.fullName}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Abbreviation: ${team.abbreviation}',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 8),
            Text(
              'City: ${team.city}',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Name: ${team.name}',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Conference: ${team.conference}',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Division: ${team.division}',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
