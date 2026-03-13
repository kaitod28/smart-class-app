import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class FinishScreen extends StatefulWidget {
  const FinishScreen({super.key});

  @override
  State<FinishScreen> createState() => _FinishScreenState();
}

class _FinishScreenState extends State<FinishScreen> {

  final TextEditingController learnedController = TextEditingController();
  final TextEditingController feedbackController = TextEditingController();

  String location = "No location";
  String qrResult = "No QR scanned";

  // GET GPS LOCATION
  Future<void> getLocation() async {

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      location = "${position.latitude}, ${position.longitude}";
    });
  }

  // OPEN QR SCANNER
  void openScanner() {

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Scan QR Code"),
          content: SizedBox(
            width: 300,
            height: 300,
            child: MobileScanner(
              onDetect: (BarcodeCapture capture) {

                final barcode = capture.barcodes.first;
                final String? code = barcode.rawValue;

                if (code != null) {

                  setState(() {
                    qrResult = code;
                  });

                  Navigator.pop(context);
                }
              },
            ),
          ),
        );
      },
    );
  }

  // SUBMIT DATA
  void submitData() {

    String learned = learnedController.text;
    String feedback = feedbackController.text;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Finish Class Data"),
        content: Text(
          "Learned Today: $learned\n"
          "Feedback: $feedback\n"
          "GPS: $location\n"
          "QR: $qrResult",
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Finish Class"),
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
                    controller: learnedController,
                    decoration: InputDecoration(
                      labelText: "What did you learn today?",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  TextField(
                    controller: feedbackController,
                    decoration: InputDecoration(
                      labelText: "Feedback",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  Center(
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.qr_code_scanner),
                      onPressed: openScanner,
                      label: const Text("Scan QR Code"),
                    ),
                  ),

                  const SizedBox(height: 12),

                  Center(
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.location_on),
                      onPressed: getLocation,
                      label: const Text("Get GPS Location"),
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
                      child: const Text("Submit Finish"),
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