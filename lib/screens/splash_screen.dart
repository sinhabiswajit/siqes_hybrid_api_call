import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:siqes_hybrid_api_call/screens/quotes_screen.dart';
import 'package:splash_view/splash_view.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SplashView(
      backgroundColor: Colors.indigo[200],
      done: Done(const QuotesScreen()),
      loadingIndicator: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/lotte_quote_animation.json', // Replace with the path to your Lottie animation file
            width: 200,
            height: 200,
            fit: BoxFit.fill,
          ),
          const SizedBox(height: 16),
          const Text(
            'QUOTES',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'A quote a day keeps the doctor away?',
            style: GoogleFonts.dancingScript(
              textStyle: const TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}