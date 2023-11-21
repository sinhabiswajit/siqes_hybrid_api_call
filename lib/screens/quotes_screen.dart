import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../api/api_service.dart';

class QuotesScreen extends StatefulWidget {
  const QuotesScreen({Key? key}) : super(key: key);

  @override
  _QuotesScreenState createState() => _QuotesScreenState();
}

class _QuotesScreenState extends State<QuotesScreen> {
  final ApiService apiService = ApiService("https://quotable.io/quotes");
  late Future<List<Map<String, dynamic>>> quotes;

  @override
  void initState() {
    super.initState();
    quotes = apiService.fetchQuotes();
  }

  void _handleExit() async {
    bool confirmExit = await _confirmExit();

    if (confirmExit) {
      // User confirmed exit, perform exit action
      Navigator.of(context).popUntil((route) => route.isFirst);
      SystemNavigator.pop(); // Exit the app
    }
  }

  Future<bool> _confirmExit() async {
    bool? result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Exit App"),
          content: const Text("Are you sure you want to exit the app?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text("No"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text("Yes"),
            ),
          ],
        );
      },
    );

    return result ?? false;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.format_quote,
          size: 30,
          color: Colors.white,
        ),
        title: const Text(
          "QUOTES",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.exit_to_app,
              color: Colors.white,
            ),
            onPressed: () {
              _handleExit();
            },
          ),
        ],
        centerTitle: true,
        backgroundColor: Colors.indigo[500],
      ),
      backgroundColor: Colors.indigo[100],
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: quotes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final quote = snapshot.data![index];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(
                      quote['content'] ?? '',
                        style: GoogleFonts.dancingScript(
                          textStyle: const TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const SizedBox(height: 4), // Add some spacing
                        Text(
                          '- ${quote['author'] ?? ''}',
                          style: const TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
