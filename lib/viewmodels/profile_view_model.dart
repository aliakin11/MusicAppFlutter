import 'package:flutter/material.dart';
import '../models/profile_track_item.dart';

class ProfileViewModel extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  
  String? _error;
  String? get error => _error;

  
  final List<Map<String, String>> _trackData = [
    {
      'title': 'Anti-Hero',
      'artist': 'Taylor Swift',
      'image': 'https://i.scdn.co/image/ab67616d0000b273bb54dde68cd23e2a268ae0f5',
    },
    {
      'title': 'Shape of You',
      'artist': 'Ed Sheeran',
      'image': 'https://i.scdn.co/image/ab67616d0000b273ba5db46f4b838ef6027e6f96',
    },
    {
      'title': '7 rings',
      'artist': 'Ariana Grande',
      'image': 'https://i.scdn.co/image/ab67616d0000b273c3af0c2355c24ed7023cd394',
    },
    {
      'title': 'God\'s Plan',
      'artist': 'Drake',
      'image': 'https://i.scdn.co/image/ab67616d0000b2739416ed64daf84936d89e671c',
    },
    {
      'title': 'Lose Yourself',
      'artist': 'Eminem',
      'image': 'https://i.scdn.co/image/ab67616d0000b273ce95acb4e8daf08eefb7eefc',
    },
  ];

  
  final List<Map<String, String>> _artistData = [
    {
      'name': 'Taylor Swift',
      'image': 'https://i.scdn.co/image/ab6761610000e5eb8ae7f2aaa9817a704a87ea36',
    },
    {
      'name': 'Ed Sheeran',
      'image': 'https://i.scdn.co/image/ab6761610000e5eb6a224073987b930f99adc8f1',
    },
    {
      'name': 'Ariana Grande',
      'image': 'https://i.scdn.co/image/ab6761610000e5ebcdce7620dc940db079bf4952',
    },
    {
      'name': 'Drake',
      'image': 'https://i.scdn.co/image/ab6761610000e5eb288ac05481cedc5bddb5b11b',
    },
    {
      'name': 'Eminem',
      'image': 'https://i.scdn.co/image/ab6761610000e5eba00b11c129b27a88fc72f36b',
    },
  ];

  List<ProfileTrackItem> getRecentlyPlayed() {
    return List.generate(
      10,
      (index) {
        final data = _trackData[index % _trackData.length];
        return ProfileTrackItem(
          id: 'track_$index',
          title: data['title']!,
          artist: data['artist']!,
          imageUrl: data['image']!,
        );
      },
    );
  }

  List<Map<String, String>> getTopArtists() {
    return _artistData;
  }

  Map<String, int> getStats() {
    return {
      'playlists': 12,
      'following': 248,
      'followers': 452,
    };
  }

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
  
  void setError(String? value) {
    _error = value;
    notifyListeners();
  }
} 