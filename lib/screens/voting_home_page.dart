import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/candidate_service.dart';
import '../widgets/candidate_card.dart';
import '../providers/theme_provider.dart';

class VotingHomePage extends StatefulWidget {
  @override
  _VotingHomePageState createState() => _VotingHomePageState();
}

class _VotingHomePageState extends State<VotingHomePage> {
  List<dynamic> candidates = [];
  bool isLoading = true;
  bool isCastingVote = false;

  @override
  void initState() {
    super.initState();
    fetchCandidates();
  }

  Future<void> fetchCandidates() async {
    setState(() => isLoading = true);
    candidates = await CandidateService.fetchCandidates();

    candidates.sort((a, b) =>
        int.parse(b['voteCount']).compareTo(int.parse(a['voteCount'])));

    setState(() => isLoading = false);
  }

  Future<void> castVote(String candidateId) async {
    setState(() => isCastingVote = true);
    await CandidateService.castVote(candidateId);
    setState(() => isCastingVote = false);
    await fetchCandidates();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('iVote'),
        centerTitle: true,
        toolbarHeight: 70,
        elevation: sqrt1_2,
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
            icon: Icon(
              themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode,
            ),
            onPressed: themeProvider.toggleTheme,
          ),
        ],
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
              color: Colors.deepPurple,
              backgroundColor: Colors.transparent,
            ))
          : Stack(
              children: [
                ListView.builder(
                  padding: EdgeInsets.all(20.0),
                  itemCount: candidates.length,
                  itemBuilder: (context, index) {
                    final candidate = candidates[index];
                    int totalVotes = candidates.fold<int>(
                      0,
                      (sum, item) => sum + int.parse(item['voteCount']),
                    );
                    double percentage = totalVotes > 0
                        ? (int.parse(candidate['voteCount']) / totalVotes) * 100
                        : 0;
                    return CandidateCard(
                      candidate: candidate,
                      percentage: percentage,
                      onVote: () => castVote(candidate['id']),
                    );
                  },
                ),
                if (isCastingVote)
                  Center(
                    child: Container(
                      color: Colors.black54,
                      child: CircularProgressIndicator(),
                    ),
                  ),
              ],
            ),
    );
  }
}
