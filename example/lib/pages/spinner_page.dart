import 'package:flutter/material.dart';
import 'package:example/widgets/spinner.dart';

class SpinnerPage extends StatelessWidget {
  const SpinnerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSection(
          title: 'Default',
          child: const Row(
            children: [
              Spinner(color: Color(0xFF18181B)),
            ],
          ),
        ),
        _buildSection(
          title: 'Colors',
          child: const Row(
            children: [
              Spinner(color: Color(0xFF18181B)),
              SizedBox(width: 24),
              Spinner(color: Color(0xFFEF4444)),
              SizedBox(width: 24),
              Spinner(color: Color(0xFF3B82F6)),
              SizedBox(width: 24),
              Spinner(color: Color(0xFF22C55E)),
            ],
          ),
        ),
        _buildSection(
          title: 'Sizes',
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 16,
                height: 16,
                child: const Spinner(color: Color(0xFF18181B)),
              ),
              const SizedBox(width: 24),
              SizedBox(
                width: 24,
                height: 24,
                child: const Spinner(color: Color(0xFF18181B)),
              ),
              const SizedBox(width: 24),
              SizedBox(
                width: 32,
                height: 32,
                child: const Spinner(color: Color(0xFF18181B)),
              ),
              const SizedBox(width: 24),
              SizedBox(
                width: 48,
                height: 48,
                child: const Spinner(color: Color(0xFF18181B)),
              ),
            ],
          ),
        ),
        _buildSection(
          title: 'Usage in context',
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: const Color(0xFFF4F4F5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spinner(color: Color(0xFF18181B)),
                SizedBox(width: 12),
                Text(
                  'Loading content...',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF71717A),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
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
