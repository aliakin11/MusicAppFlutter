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

  Future<List<Map<String, dynamic>>> getTracks(List<String> trackIds) async {
    if (!isAuthenticated) await authenticate();
    
    final ids = trackIds.join(',');
    final response = await http.get(
      Uri.parse('https://api.spotify.com/v1/tracks?ids=$ids'),
      headers: {
        'Authorization': 'Bearer $_accessToken',
      },
    );
    
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return List<Map<String, dynamic>>.from(data['tracks']);
    } else {
      throw Exception('Failed to get tracks');
    }
  }

  Future<List<Map<String, dynamic>>> getRecommendedTracks() async {
    if (!isAuthenticated) await authenticate();
    
    final response = await http.get(
      Uri.parse('https://api.spotify.com/v1/recommendations?limit=50&market=TR&seed_genres=pop,rock,hip-hop'),
      headers: {
        'Authorization': 'Bearer $_accessToken',
      },
    );
    
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return List<Map<String, dynamic>>.from(data['tracks']);
    } else {
      throw Exception('Failed to get recommended tracks');
    }
  }

  Future<List<Map<String, dynamic>>> getAllTracks() async {
    if (!isAuthenticated) await authenticate();
    
    
    final categories = await getMusicCategories();
    List<Map<String, dynamic>> allTracks = [];
    
  
    for (String category in categories) {
      try {
        final categoryTracks = await getCategoryTracks(category);
        allTracks.addAll(categoryTracks);
      } catch (e) {
        print('Error fetching tracks for category $category: $e');
        continue;
      }
    }
    
    return allTracks;
  }

  Future<List<Map<String, dynamic>>> getCategoryTracks(String category) async {
    final response = await http.get(
      Uri.parse('https://api.spotify.com/v1/search?q=genre:$category&type=track&limit=20&market=TR'),
      headers: {
        'Authorization': 'Bearer $_accessToken',
      },
    );
    
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final tracks = data['tracks']['items'] as List;
      
      
      return List<Map<String, dynamic>>.from(tracks);
    } else {
      throw Exception('Failed to get tracks for category $category');
    }
  }


  Future<List<Map<String, dynamic>>> getTracksByCategory(String category) async {
    if (category.toLowerCase() == 'all') {
      return getAllTracks();
    }
    
    return getCategoryTracks(category);
  }

  Future<Map<String, dynamic>> getAlbumDetails(String albumId) async {
    final response = await http.get(
      Uri.parse('https://api.spotify.com/v1/albums/$albumId'),
      headers: {
        'Authorization': 'Bearer $_accessToken',
      },
    );
    
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to get album details');
    }
  }

  Future<List<Map<String, dynamic>>> searchTracks(String query) async {
    if (!isAuthenticated) await authenticate();
    
    final response = await http.get(
      Uri.parse('https://api.spotify.com/v1/search?q=$query&type=track&market=TR&limit=20'),
      headers: {
        'Authorization': 'Bearer $_accessToken',
      },
    );
    
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return List<Map<String, dynamic>>.from(data['tracks']['items']);
    } else {
      throw Exception('Failed to search tracks');
    }
  }

  
  
}