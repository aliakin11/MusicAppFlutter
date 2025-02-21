import 'package:flutter/material.dart';

class LibraryItem {
  final String id;
  final String title;
  final String subtitle;
  final IconData icon;
  final String? imageUrl;
  final bool isCircular;

  LibraryItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.imageUrl,
    this.isCircular = false,
  });
}