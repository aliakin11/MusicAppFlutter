import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/library_view_model.dart';
import '../constants/app_theme.dart';
import '../widgets/library_card.dart';
import '../models/library_item.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<LibraryViewModel>(
      builder: (context, viewModel, child) {
        return Scaffold(
          backgroundColor: AppTheme.background,
          body: SafeArea(
            child: DefaultTabController(
              length: 3,
              initialIndex: viewModel.selectedTabIndex,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(context),
                  _buildTabBar(),
                  _buildTabBarView(viewModel, context),
                ],
              ),
            ),
          ),
          floatingActionButton: _buildFAB(viewModel),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        'Your Library',
        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
          color: AppTheme.textLight,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return const TabBar(
      tabs: [
        Tab(text: 'Playlists'),
        Tab(text: 'Artists'),
        Tab(text: 'Albums'),
      ],
      labelColor: AppTheme.accent,
      unselectedLabelColor: AppTheme.textGrey,
      indicatorColor: AppTheme.accent,
    );
  }

  Widget _buildTabBarView(LibraryViewModel viewModel, BuildContext context) {
    return Expanded(
      child: TabBarView(
        children: [
          _buildGrid(context, viewModel.playlists),
          _buildGrid(context, viewModel.artists),
          _buildGrid(context, viewModel.albums),
        ],
      ),
    );
  }

  Widget _buildGrid(BuildContext context, List<LibraryItem> items) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: MediaQuery.of(context).size.width > 600 ? 4 : 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) => LibraryCard(item: items[index]),
    );
  }

  Widget _buildFAB(LibraryViewModel viewModel) {
    return FloatingActionButton(
      onPressed: viewModel.createNewPlaylist,
      backgroundColor: AppTheme.accent,
      child: const Icon(Icons.add, color: AppTheme.textLight),
    );
  }
}