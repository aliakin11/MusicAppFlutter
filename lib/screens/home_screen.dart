import 'package:flutter/material.dart';
import 'package:music_app/constants/app_theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ana Sayfa'),
        backgroundColor: AppTheme.accent,
      ),
      body: Center(
        child: Text(
          'Hoş Geldiniz!',
          style: TextStyle(
            fontSize: 24,
            color: AppTheme.textLight,
          ),
        ),
      ),
    );
  }
} 