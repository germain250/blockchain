import 'package:flutter/material.dart';

class CandidateCard extends StatelessWidget {
  final Map candidate;
  final double percentage;
  final VoidCallback onVote;

  CandidateCard({
    required this.candidate,
    required this.percentage,
    required this.onVote,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  child: Image.network(
                    "https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png",
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        candidate['name'],
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Text(candidate['manifesto']),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: onVote,
                  child: Text('Vote'),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Text(
              'Votes: ${candidate['voteCount']} (${percentage.toStringAsFixed(1)}%)',
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 8.0),
            LinearProgressIndicator(
              value: percentage / 100,
              backgroundColor: Colors.grey[800],
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}
