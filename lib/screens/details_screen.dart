import 'package:flutter/material.dart';
import '../viewmodels/home_view_model.dart';
import '../widgets/wave_progress_bar.dart';
import '../constants/app_theme.dart';

class PodcastDetailsScreen extends StatelessWidget {
  final PodcastModel podcast;

  const PodcastDetailsScreen({
    Key? key,
    required this.podcast,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    
    return Theme(
      data: AppTheme.darkTheme,
      child: Scaffold(
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                children: [
                  _buildHeader(context),
                  Expanded(
                    child: SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: constraints.maxHeight - 56, // header height
                        ),
                        child: IntrinsicHeight(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildPodcastImage(size),
                              _buildPodcastInfo(),
                              Column(
                                children: [
                                  _buildProgressBar(),
                                  SizedBox(height: size.height * 0.02),
                                  _buildControls(size),
                                ],
                              ),
                              // Bottom padding for safe area
                              SizedBox(height: padding.bottom),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return SizedBox(
      height: 56,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
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
      ),
    );
  }

  Widget _buildPodcastImage(Size size) {
    final imageSize = size.width * (size.height > 800 ? 0.7 : 0.6);
    return Container(
      width: imageSize,
      height: imageSize,
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.05,
        vertical: size.height * 0.02,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.asset(
          podcast.imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildPodcastInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            podcast.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            podcast.author,
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          WaveProgressBar(progress: 0.7),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '24:32',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 12,
                ),
              ),
              Text(
                '34:00',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildControls(Size size) {
    final buttonSize = size.width * 0.15;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.1,
        vertical: size.height * 0.02,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: const Icon(
              Icons.skip_previous,
              color: Colors.white,
              size: 36,
            ),
            onPressed: () {},
          ),
          Container(
            width: buttonSize,
            height: buttonSize,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(
                Icons.play_arrow,
                size: buttonSize * 0.6,
              ),
              onPressed: () {},
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.skip_next,
              color: Colors.white,
              size: 36,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
} 