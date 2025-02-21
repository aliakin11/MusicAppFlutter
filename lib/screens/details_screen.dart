import 'package:flutter/material.dart';
import '../widgets/wave_progress_bar.dart';
import '../constants/app_theme.dart';
import '../services/spotify_service.dart';
import 'package:audioplayers/audioplayers.dart';

class DetailsScreen extends StatelessWidget {
  final Map<String, dynamic> podcast;
  final String trackId;

  
  DetailsScreen({Key? key, required this.podcast})
      : trackId = podcast['id'] != null ? podcast['id'] as String : '', 
        super(key: key);


  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    final String title = podcast['name'] ?? 'Unknown Track';
    final String artist = (podcast['artists'] as List?)?.map((a) => a['name']).join(', ') ?? 'Unknown Artist';
    final List<dynamic> images = podcast['album']['images'] ?? [];
    final String imageUrl = images.isNotEmpty ? images[0]['url'] : '';

    return Theme(
      data: AppTheme.darkTheme,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildHeader(context),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _buildPodcastImage(imageUrl, screenWidth),
                      SizedBox(height: screenHeight * 0.03),
                      _buildPodcastInfo(title, artist, screenWidth),
                      SizedBox(height: screenHeight * 0.03),
                      _buildProgressBar(screenWidth),
                      SizedBox(height: screenHeight * 0.03),
                      _buildControls(screenWidth),
                      SizedBox(height: screenHeight * 0.02),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          const Expanded(
            child: Center(
              child: Text(
                'Now Playing',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 40),
        ],
      ),
    );
  }

  Widget _buildPodcastImage(String imageUrl, double screenWidth) {
    return AspectRatio(
      aspectRatio: 1,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(screenWidth * 0.04),
        child: imageUrl.isNotEmpty
            ? Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: Colors.grey,
                  child: const Icon(Icons.error, color: Colors.white),
                ),
              )
            : Container(color: Colors.grey),
      ),
    );
  }

  Widget _buildPodcastInfo(String title, String artist, double screenWidth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: screenWidth * 0.06,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: screenWidth * 0.02),
        Text(
          artist,
          style: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontSize: screenWidth * 0.04,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildProgressBar(double screenWidth) {
    return Column(
      children: [
        SizedBox(
          width: screenWidth * 0.8,
          child: WaveProgressBar(progress: 0.7),
        ),
        SizedBox(height: screenWidth * 0.02),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '24:32',
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: screenWidth * 0.035,
              ),
            ),
            Text(
              '34:00',
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: screenWidth * 0.035,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildControls(double screenWidth) {
    final spotifyService = SpotifyService();
    final AudioPlayer audioPlayer = AudioPlayer();

    return Padding(
      padding: EdgeInsets.only(bottom: screenWidth * 0.08),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(Icons.skip_previous, color: Colors.white, size: screenWidth * 0.09),
            onPressed: () {},
          ),
          SizedBox(width: screenWidth * 0.1),
          Container(
            width: screenWidth * 0.15,
            height: screenWidth * 0.15,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(Icons.play_arrow, size: screenWidth * 0.08),
              onPressed: () {},
            ),
          ),
          SizedBox(width: screenWidth * 0.1),
          IconButton(
            icon: Icon(Icons.skip_next, color: Colors.white, size: screenWidth * 0.09),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
} 