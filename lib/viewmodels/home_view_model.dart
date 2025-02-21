import 'package:flutter/material.dart';
import '../services/spotify_service.dart';

class HomeViewModel extends ChangeNotifier {
  final SpotifyService _spotifyService = SpotifyService();
  
  
  List<String> _categories = ['All'];
  List<String> get categories => _categories;
  
  int _selectedCategoryIndex = 0;
  int get selectedCategoryIndex => _selectedCategoryIndex;
  
  
  List<Map<String, dynamic>> _tracks = [];
  List<Map<String, dynamic>> get tracks => _tracks;
  
  bool _isLoading = true;
  bool get isLoading => _isLoading;
  
  String? _error;
  String? get error => _error;

  HomeViewModel() {
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    try {
      _isLoading = true;
      notifyListeners();

     
      await _loadCategories();
      
      
      await _loadTracks();
      
      _error = null;
    } catch (e) {
      _error = 'Failed to load data: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _loadCategories() async {
    try {
      final spotifyCategories = await _spotifyService.getMusicCategories();
      _categories = ['All', ...spotifyCategories];
    } catch (e) {
      print('Category error: $e');
      throw Exception('Failed to load categories');
    }
  }

  Future<void> _loadTracks() async {
    try {
      _tracks = await _spotifyService.getAllTracks();
    } catch (e) {
      print('Tracks error: $e');
      throw Exception('Failed to load tracks');
    }
  }

  Future<void> selectCategory(int index) async {
    _selectedCategoryIndex = index;
    _isLoading = true;
    notifyListeners();

    try {
      final category = _categories[index];
      _tracks = await _spotifyService.getTracksByCategory(category);
    } catch (e) {
      _error = 'Failed to load tracks for category: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> searchTracks(String query) async {
    _isLoading = true;
    notifyListeners();

    try {
      if (query.isEmpty) {
        await _loadTracks();
      } else {
        _tracks = await _spotifyService.searchTracks(query);
        _error = null;
      }
    } catch (e) {
      _error = 'Failed to search tracks: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

class PodcastModel {
  final String title;
  final String author;
  final String imageUrl;
  PodcastModel({
    required this.title,
    required this.author,
    required this.imageUrl,
  });
}
