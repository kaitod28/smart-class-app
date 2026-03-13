import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class CheckinScreen extends StatefulWidget {
  const CheckinScreen({super.key});

  @override
  State<CheckinScreen> createState() => _CheckinScreenState();
}

class _CheckinScreenState extends State<CheckinScreen> {

  final TextEditingController previousController = TextEditingController();
  final TextEditingController expectedController = TextEditingController();

  String location = "No location";
  String qrResult = "No QR scanned";

  int selectedMood = 0;

  Future<void> getLocation() async {

    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      location = "${position.latitude}, ${position.longitude}";
    });

  }

  void openScanner() {

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(

          appBar: AppBar(
            title: const Text("Scan QR Code"),
          ),

          body: MobileScanner(

            onDetect: (BarcodeCapture capture) {

              final Barcode? barcode = capture.barcodes.isNotEmpty
                  ? capture.barcodes.first
                  : null;

              final String? code = barcode?.rawValue;

              if (code != null) {

                setState(() {
                  qrResult = code;
                });

                Navigator.pop(context);
              }

            },

          ),

        ),
      ),
    );

  }

  Widget moodIcon(int value, String emoji) {

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedMood = value;
        });
      },

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(10),

        decoration: BoxDecoration(
          color: selectedMood == value
              ? Colors.orange.withOpacity(0.3)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),

        child: Text(
          emoji,
          style: const TextStyle(fontSize: 32),
        ),
      ),
    );

  }

  void submitData() {

    if (selectedMood == 0) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please select your mood before check-in"),
        ),
      );

      return;
    }

    String previous = previousController.text;
    String expected = expectedController.text;

    showDialog(
      context: context,

      builder: (_) => AlertDialog(

        title: const Text("Check-in Data"),

        content: Text(
          "Previous: $previous\nExpected: $expected\nMood: $selectedMood\nGPS: $location\nQR: $qrResult",
        ),

      ),

    );

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Check-in"),
      ),

      body: SingleChildScrollView(

        child: Padding(
          padding: const EdgeInsets.all(20),

          child: Card(
            elevation: 6,

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),

            child: Padding(
              padding: const EdgeInsets.all(20),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  TextField(
                    controller: previousController,

                    decoration: InputDecoration(
                      labelText: "Previous Topic",

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),

                    ),
                  ),

                  const SizedBox(height: 16),

                  TextField(
                    controller: expectedController,

                    decoration: InputDecoration(
                      labelText: "Expected Topic",

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    "Mood before class",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [

                      moodIcon(1, "😡"),
                      moodIcon(2, "🙁"),
                      moodIcon(3, "😐"),
                      moodIcon(4, "🙂"),
                      moodIcon(5, "😄"),

                    ],
                  ),

                  const SizedBox(height: 24),

                  Center(
                    child: ElevatedButton.icon(

                      icon: const Icon(Icons.qr_code_scanner),

                      label: const Text("Scan QR Code"),

                      onPressed: openScanner,

                    ),
                  ),

                  const SizedBox(height: 12),

                  Center(
                    child: ElevatedButton.icon(

                      icon: const Icon(Icons.location_on),

                      label: const Text("Get GPS Location"),

                      onPressed: getLocation,

                    ),
                  ),

                  const SizedBox(height: 20),

                  Row(
                    children: [

                      const Icon(Icons.location_on, color: Colors.orange),

                      const SizedBox(width: 8),

                      Expanded(child: Text(location)),

                    ],
                  ),

                  const SizedBox(height: 8),

                  Row(
                    children: [

                      const Icon(Icons.qr_code, color: Colors.orange),

                      const SizedBox(width: 8),

                      Expanded(child: Text(qrResult)),

                    ],
                  ),

                  const SizedBox(height: 24),

                  Center(
                    child: ElevatedButton(

                      onPressed: submitData,

                      child: const Text("Submit Check-in"),

                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}