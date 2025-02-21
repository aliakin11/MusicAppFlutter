import 'package:flutter/material.dart';
import 'package:music_app/constants/app_theme.dart';
import 'package:music_app/models/onboarding_model.dart';
import 'package:music_app/screens/home_screen.dart';
import 'package:music_app/services/shared_preferences_service.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {

  final PageController _pageController = PageController(initialPage: 0); 
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
  void dispose() {
    _pageController.dispose(); 
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final screenHeight = constraints.maxHeight;
          
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  const Text(
                    'Getting Started',
                    style: TextStyle(
                      color: AppTheme.textGrey,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.04),
                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      physics: const ClampingScrollPhysics(),
                      onPageChanged: (index) {
                        setState(() => _currentPage = index);
                      },
                      itemCount: _pages.length,
                      itemBuilder: (context, index) {
                        return _buildPage(_pages[index], constraints);
                      },
                    ),
                  ),
                  const SizedBox(height: 32),
                  _buildNextButton(constraints),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPage(OnboardingModel page, BoxConstraints constraints) {
    final textTheme = AppTheme.getResponsiveTextTheme(context);
    return Column(
      children: [
        Container(
          width: constraints.maxWidth * 0.85,
          height: constraints.maxHeight * 0.35,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(140),
              bottom: Radius.circular(32),
            ),
            image: DecorationImage( 
              image: AssetImage(page.imagePath!),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const Spacer(),
        Column(
          children: [
            Text(page.title, style: textTheme.displayLarge),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                page.description,
                style: textTheme.bodyLarge,
                textAlign: TextAlign.center,
                maxLines: 3,
              ),
            ),
            const SizedBox(height: 40),
            _buildIndicator(),
          ],
        ),
        const Spacer(),
      ],
    );
  }

  Widget _buildIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _pages.map((e) {
        final index = _pages.indexOf(e);
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200), 
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: _currentPage == index ? 24 : 8,
          height: 8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: _currentPage == index ? AppTheme.accent : AppTheme.textGrey,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildNextButton(BoxConstraints constraints) {
    final buttonSize = constraints.maxWidth * 0.15;

    return GestureDetector(
      onTap: () {
        
        debugPrint("Tıklandı - Mevcut sayfa: $_currentPage");
        if (_currentPage < _pages.length - 1) {
          _pageController.animateToPage(
            _currentPage + 1,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        } else {
          SharedPreferencesService().setOnboardingSeen();
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        }
      },
      child: Container(
        width: buttonSize,
        height: buttonSize,
        decoration: BoxDecoration(
          color: AppTheme.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Icon(
          Icons.arrow_forward,
          color: AppTheme.accent,
          size: buttonSize * 0.4,
        ),
      ),
    );
  }
}