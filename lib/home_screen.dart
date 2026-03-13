import 'package:flutter/material.dart';
import 'checkin_screen.dart';
import 'finish_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Smart Class App"),
      ),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              const Icon(
                Icons.school,
                size: 80,
                color: Colors.orange,
              ),

              const SizedBox(height: 20),

              const Text(
                "Welcome to Smart Class",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 40),

              SizedBox(
                width: 200,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.login),
                  label: const Text("Check-in"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CheckinScreen(),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: 200,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.check_circle),
                  label: const Text("Finish Class"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FinishScreen(),
                      ),
                    );
                  },
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}