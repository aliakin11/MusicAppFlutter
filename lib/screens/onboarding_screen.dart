import 'package:flutter/material.dart';
import 'package:music_app/constants/app_theme.dart';
import 'package:music_app/models/onboarding_model.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingModel> _pages = [
    OnboardingModel(
      title: 'Podkes',
      description: 'A podcast is an episodic series of spoken word digital audio files that a user can download to a personal device for easy listening.',
      imagePath: 'assets/images/onboarding1.png',
    ),
    OnboardingModel(
      title: 'Discover',
      description: 'Discover new podcasts and episodes.',
      imagePath: 'assets/images/onboarding2.png',
    ),
    OnboardingModel(
      title: 'Listen',
      description: 'Listen to your favorite podcasts.',
      imagePath: 'assets/images/onboarding3.png',
    ),
    
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: _pages.length,
                itemBuilder: (context, index) {
                  return _buildPage(_pages[index]);
                },
              ),
            ),
            _buildIndicator(),
            _buildNextButton(),
            SizedBox(height: size.height * 0.05), 
          ],
        ),
      ),
    );
  }

  Widget _buildPage(OnboardingModel page) {
    
    final size = MediaQuery.of(context).size;
    
    
    final imageWidth = size.width * 0.65;
    
    final imageHeight = imageWidth * 1.32;

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (page.imagePath != null) ...[
            Container(
              width: imageWidth,  
              height: imageHeight, 
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                ),
                color: AppTheme.white,
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                ),
                child: Image.asset(
                  page.imagePath!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: size.height * 0.05),
          ],
          Text(
            page.title,
            style: Theme.of(context).textTheme.displayLarge,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: size.height * 0.02), 
          Text(
            page.description,
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        _pages.length,
        (index) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentPage == index 
                ? AppTheme.accent 
                : AppTheme.textGrey,
          ),
        ),
      ),
    );
  }

  Widget _buildNextButton() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: GestureDetector(
        onTap: () {
          if (_currentPage < _pages.length - 1) {
            _pageController.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeIn,
            );
          } else {
            
          }
        },
        child: Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(16),
            color: AppTheme.white,
          ),
          child: Icon(
            Icons.arrow_forward,
            color: AppTheme.accent,
            size: 24,
          ),
        ),
      ),
    );
  }
} 