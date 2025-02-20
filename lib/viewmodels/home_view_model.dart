import 'package:flutter/material.dart';
import '../services/spotify_service.dart';

class HomeViewModel extends ChangeNotifier {
  final _spotifyService = SpotifyService();
  
  List<String> _categories = ['All'];
  List<String> get categories => _categories;
  
  int _selectedCategoryIndex = 0;
  int get selectedCategoryIndex => _selectedCategoryIndex;
  
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  
  String? _error;
  String? get error => _error;

   List<PodcastModel> trendingPodcasts = [
    PodcastModel(
      title: 'The missing 96 percent of the universe',
      author: 'Claire Malone',
      imageUrl: 'assets/images/onboarding1.png',
    ),
    PodcastModel(
      title: 'How Dolly Parton led me to an epiphany',
      author: 'Abumenyang',
      imageUrl: 'assets/images/onboarding2.png',
    ),
    
  ];

  HomeViewModel() {
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    try {
      _isLoading = true;
      notifyListeners();

      final spotifyCategories = await _spotifyService.getMusicCategories();
      _categories = ['All', ...spotifyCategories];
      _error = null;
    } catch (e) {
      _error = 'Kategoriler yüklenirken bir hata oluştu';
      print('Category error: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void selectCategory(int index) {
    _selectedCategoryIndex = index;
    notifyListeners();
    // Daha sonra seçilen kategoriye göre müzikleri filtreleyebiliriz
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