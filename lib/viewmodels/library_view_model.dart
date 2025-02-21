import 'package:flutter/material.dart';
import '../models/library_item.dart';

class LibraryViewModel extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  
  String? _error;
  String? get error => _error;

  int _selectedTabIndex = 0;
  int get selectedTabIndex => _selectedTabIndex;

  final List<String> _playlistImages = [
    'https://images.unsplash.com/photo-1511735111819-9a3f7709049c',
    'https://images.unsplash.com/photo-1514320291840-2e0a9bf2a9ae',
    'https://images.unsplash.com/photo-1459749411175-04bf5292ceea',
    'https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f',
    'https://images.unsplash.com/photo-1510915361894-db8b60106cb1',
  ];

  final List<String> _artistImages = [
    'https://i.scdn.co/image/ab6761610000e5eb8ae7f2aaa9817a704a87ea36',
    'https://i.scdn.co/image/ab6761610000e5eb6a224073987b930f99adc8f1',
    'https://i.scdn.co/image/ab6761610000e5ebcdce7620dc940db079bf4952',
    'https://i.scdn.co/image/ab6761610000e5eb288ac05481cedc5bddb5b11b',
    'https://i.scdn.co/image/ab6761610000e5eba00b11c129b27a88fc72f36b',
  ];

  final List<String> _albumImages = [
    'https://i.scdn.co/image/ab67616d0000b273bb54dde68cd23e2a268ae0f5',
    'https://i.scdn.co/image/ab67616d0000b273cf8d0d607c8e3f4d8a12afe0',
    'https://i.scdn.co/image/ab67616d0000b2735ef878a782c987d38d82b605',
    'https://i.scdn.co/image/ab67616d0000b273f907de96b9a4fbc04accc0d5',
    'https://i.scdn.co/image/ab67616d0000b273e4073def0c03a91e3fceaf73',
  ];

  final List<LibraryItem> _playlists = [];
  final List<LibraryItem> _artists = [];
  final List<LibraryItem> _albums = [];

  LibraryViewModel() {
    _initializeData();
  }

  void _initializeData() {
    _playlists.addAll(
      List.generate(
        10,
        (index) => LibraryItem(
          id: 'playlist_$index',
          title: 'My Playlist #${index + 1}',
          subtitle: '12 tracks',
          icon: Icons.playlist_play,
          imageUrl: _playlistImages[index % _playlistImages.length],
        ),
      ),
    );

    _artists.addAll(
      List.generate(
        10,
        (index) => LibraryItem(
          id: 'artist_$index',
          title: _getArtistName(index),
          subtitle: '${(index + 2) * 3} albums',
          icon: Icons.person,
          imageUrl: _artistImages[index % _artistImages.length],
          isCircular: true,
        ),
      ),
    );

    _albums.addAll(
      List.generate(
        10,
        (index) => LibraryItem(
          id: 'album_$index',
          title: _getAlbumName(index),
          subtitle: _getArtistName(index),
          icon: Icons.album,
          imageUrl: _albumImages[index % _albumImages.length],
        ),
      ),
    );
  }

  String _getArtistName(int index) {
    final artists = [
      'Taylor Swift',
      'Ed Sheeran',
      'Ariana Grande',
      'Drake',
      'Eminem',
      'The Weeknd',
      'Billie Eilish',
      'Post Malone',
      'Dua Lipa',
      'Justin Bieber',
    ];
    return artists[index % artists.length];
  }

  String _getAlbumName(int index) {
    final albums = [
      'Midnights',
      '= (Equals)',
      'Positions',
      'Her Loss',
      'The Marshall Mathers LP',
      'After Hours',
      'Happier Than Ever',
      "Hollywood's Bleeding",
      'Future Nostalgia',
      'Justice',
    ];
    return albums[index % albums.length];
  }

  List<LibraryItem> get playlists => _playlists;
  List<LibraryItem> get artists => _artists;
  List<LibraryItem> get albums => _albums;

  void setSelectedTab(int index) {
    _selectedTabIndex = index;
    notifyListeners();
  }

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setError(String? value) {
    _error = value;
    notifyListeners();
  }

  Future<void> createNewPlaylist() async {}
}