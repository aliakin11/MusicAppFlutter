import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SpotifyService {
  
 final String clientId = dotenv.env['SPOTIFY_CLIENT_ID'] ?? '';
  final String clientSecret = dotenv.env['SPOTIFY_CLIENT_SECRET'] ?? '';
  
  
  static const String _authUrl = 'https://accounts.spotify.com/api/token';
  
  String? _accessToken;
  DateTime? _tokenExpireTime;

  
  static final SpotifyService _instance = SpotifyService._internal();
  
  factory SpotifyService() {
    return _instance;
  }
  
  SpotifyService._internal();

  
  Future<bool> authenticate() async {
    try {
      final response = await http.post(
        Uri.parse(_authUrl),
        headers: {
          'Authorization': 'Basic ' + 
              base64Encode(utf8.encode('$clientId:$clientSecret')),
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'grant_type': 'client_credentials',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _accessToken = data['access_token'];
        _tokenExpireTime = DateTime.now().add(
          Duration(seconds: data['expires_in']),
        );
        return true;
      }
      return false;
    } catch (e) {
      print('Spotify authentication error: $e');
      return false;
    }
  }

  
  bool get isAuthenticated {
    return _accessToken != null && 
           _tokenExpireTime != null && 
           _tokenExpireTime!.isAfter(DateTime.now());
  }

  
  String? get accessToken => _accessToken;

  
  Future<List<String>> getMusicCategories() async {
    if (!isAuthenticated) await authenticate();
    
    final response = await http.get(
      Uri.parse('https://api.spotify.com/v1/browse/categories?country=TR'),
      headers: {
        'Authorization': 'Bearer $_accessToken',
      },
    );
    
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['categories']['items'] as List)
          .map((category) => category['name'] as String)
          .toList();
    } else {
      throw Exception('Failed to get categories');
    }
  }

  
 

  
}