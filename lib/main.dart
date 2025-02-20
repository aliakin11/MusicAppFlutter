import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:music_app/constants/app_theme.dart';
import 'package:music_app/screens/onboarding_screen.dart';
import 'package:music_app/screens/home_screen.dart';
import 'package:music_app/services/shared_preferences_service.dart';
import 'package:music_app/services/spotify_service.dart';
import 'viewmodels/home_view_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await dotenv.load(fileName: ".env");
  
  
  final spotifyService = SpotifyService();
  final isConnected = await spotifyService.authenticate();
  
  if (isConnected) {
    print('Spotify API bağlantısı başarılı!');
    print('Access Token: ${spotifyService.accessToken}');
  } else {
    print('Spotify API bağlantısı başarısız!');
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
      ],
      child: MaterialApp(
        title: 'Podkes',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,
        home: FutureBuilder<bool>(
          future: SharedPreferencesService().isOnboardingSeen(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.data == true) {
              return const HomeScreen();
            }
            return const OnboardingScreen(); 
          },
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.accent,
        centerTitle: true,
        title: Text(
          widget.title,
          style: const TextStyle(
            color: AppTheme.textLight,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppTheme.accent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(
          Icons.add,
          color: AppTheme.white,
        ),
      ),
    );
  }
}
