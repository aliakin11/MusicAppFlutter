import 'package:flutter/material.dart';

class ProfileTrackItem {
  final String id;
  final String title;
  final String artist;
  final String imageUrl;
  final IconData icon;

  ProfileTrackItem({
    required this.id,
    required this.title,
    required this.artist,
    required this.imageUrl,
    this.icon = Icons.music_note,
  });
} 