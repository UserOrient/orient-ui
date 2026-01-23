import 'package:example/widgets/button.dart';
import 'package:example/widgets/empty.dart';
import 'package:flutter/material.dart';

class EmptyPage extends StatelessWidget {
  const EmptyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSection(
            title: 'Default',
            child: Empty(
              icon: Icon(
                Icons.notifications_off_outlined,
                size: 48,
                color: Colors.black26,
              ),
              title: 'No notifications',
              description:
                  'When we send you notifications, you\'ll be able to see them here.',
            ),
          ),
          _buildSection(
            title: 'With Action',
            child: Empty(
              icon: Icon(
                Icons.gps_off_outlined,
                size: 48,
                color: Colors.black26,
              ),
              title: 'Location Disabled',
              description:
                  'Please enable GPS services from settings of your device.',
              action: Button.small(
                onPressed: () {},
                icon: Icon(Icons.settings),
                label: 'Open Settings',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({required String title, required Widget child}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF71717A),
            ),
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}
