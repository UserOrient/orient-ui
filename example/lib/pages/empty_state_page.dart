import 'package:example/widgets/button.dart';
import 'package:example/widgets/demo_section.dart';
import 'package:example/widgets/empty_state.dart';
import 'package:flutter/material.dart';

class EmptyStatePage extends StatelessWidget {
  const EmptyStatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DemoSection(
          title: 'Default',
          child: EmptyState(
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
        const SizedBox(height: 24),
        DemoSection(
          title: 'With Action',
          child: EmptyState(
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
    );
  }
}
