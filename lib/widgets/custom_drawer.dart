import 'package:flutter/material.dart';
import '../constants/app_theme.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 600;

    return Drawer(
      backgroundColor: AppTheme.background,
      child: SafeArea(
        child: Column(
          children: [
            DrawerHeader(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: isSmallScreen ? 40 : 50,
                    backgroundColor: Colors.grey[850],
                    child: Icon(
                      Icons.person,
                      size: isSmallScreen ? 40 : 50,
                      color: AppTheme.textGrey,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Guest User',
                    style: TextStyle(
                      color: AppTheme.textLight,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            _buildMenuItem(
              icon: Icons.home,
              title: 'Home',
              onTap: () => Navigator.pop(context),
            ),
            _buildMenuItem(
              icon: Icons.favorite,
              title: 'Favorites',
              onTap: () {},
            ),
            _buildMenuItem(
              icon: Icons.playlist_play,
              title: 'Playlists',
              onTap: () {},
            ),
            _buildMenuItem(
              icon: Icons.history,
              title: 'History',
              onTap: () {},
            ),
            _buildMenuItem(
              icon: Icons.settings,
              title: 'Settings',
              onTap: () {},
            ),
            const Spacer(),
            const Divider(color: AppTheme.textGrey),
            _buildMenuItem(
              icon: Icons.logout,
              title: 'Logout',
              onTap: () {},
              isDestructive: true,
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: isDestructive ? Colors.red : AppTheme.textLight,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isDestructive ? Colors.red : AppTheme.textLight,
          fontSize: 16,
        ),
      ),
      onTap: onTap,
      hoverColor: Colors.grey[850],
    );
  }
} 