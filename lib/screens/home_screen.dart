import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/home_view_model.dart';
import '../widgets/category_chip.dart';
import '../widgets/podcast_card.dart';
import '../widgets/bottom_nav_item.dart';
import '../screens/details_screen.dart';

import '../screens/profile_screen.dart';
import '../constants/app_theme.dart';
import '../widgets/custom_drawer.dart';
import '../widgets/notifications_sheet.dart';
import '../screens/library_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    _HomeView(),
    LibraryScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, viewModel, child) {
        return SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.menu),
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                    ),
                    const Text(
                      'Podkes',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Stack(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.notifications_outlined),
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              backgroundColor: Colors.transparent,
                              builder: (context) => const NotificationsSheet(),
                            );
                          },
                        ),
                        Positioned(
                          right: 12,
                          top: 12,
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SearchBar(
                  hintText: 'Search tracks...',
                  hintStyle: MaterialStateProperty.all(
                    const TextStyle(color: AppTheme.textGrey),
                  ),
                  leading: const Icon(
                    Icons.search,
                    color: AppTheme.textGrey,
                  ),
                  backgroundColor: MaterialStateProperty.all(Colors.grey[850]),
                  padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                  onChanged: (query) {
                    viewModel.searchTracks(query);
                  },
                  textStyle: MaterialStateProperty.all(
                    const TextStyle(color: AppTheme.textLight),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: List.generate(
                    viewModel.categories.length,
                    (index) => Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: CategoryChip(
                        label: viewModel.categories[index],
                        isSelected: viewModel.selectedCategoryIndex == index,
                        onTap: () => viewModel.selectCategory(index),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Text(
                      'Trending',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              
              if (viewModel.isLoading)
                const Center(child: CircularProgressIndicator())
              else if (viewModel.error != null)
                Center(child: Text(viewModel.error!))
              else if (viewModel.tracks.isEmpty)
                const Center(child: Text('No tracks found'))
              else
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.75,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: viewModel.tracks.length,
                    itemBuilder: (context, index) {
                      return PodcastCard(
                        podcast: viewModel.tracks[index],
                        onTap: () {
                          _navigateToDetails(context, viewModel.tracks[index]);
                        },
                      );
                    },
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  void _navigateToDetails(BuildContext context, Map<String, dynamic> podcast) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailsScreen(podcast: podcast),
      ),
    );
  }
}

