import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/resources_screen.dart';
import 'screens/documents_screen.dart';
import 'screens/forum_screen.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';

void main() async {
  // Set up the SettingsController, which will glue user settings to multiple
  // Flutter Widgets.
  final settingsController = SettingsController(SettingsService());

  // Load the user's preferred theme while the splash screen is displayed.
  // This prevents a sudden theme change when the app is first displayed.
  await settingsController.loadSettings();

  // Run the app and pass in the SettingsController.
  runApp(WayfarerApp(settingsController: settingsController));
}

class WayfarerApp extends StatelessWidget {
  final SettingsController settingsController;

  WayfarerApp({required this.settingsController});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.latoTextTheme(),
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Wayfarer")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            HomeButton("📄 Documents", () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => DocumentsScreen()));
            }),
            HomeButton("📚 Resources", () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => ResourcesScreen()));
            }),
            HomeButton("🏡 Forum", () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => ForumScreen()));
            }),
          ],
        ),
      ),
    );
  }
}

class HomeButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  HomeButton(this.text, this.onPressed);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
          textStyle: TextStyle(fontSize: 18),
        ),
        onPressed: onPressed,
        child: Text(text),
      ),
    );
  }
}