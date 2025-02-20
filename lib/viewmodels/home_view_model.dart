import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  List<String> categories = ['All', 'Life', 'Comedy', 'Tech'];
  int selectedCategoryIndex = 0;
  
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

  void selectCategory(int index) {
    selectedCategoryIndex = index;
    notifyListeners();
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