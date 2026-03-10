import 'package:flutter/material.dart';
import 'package:example/widgets/demo_section.dart';
import 'package:example/widgets/spinner.dart';

class SpinnerPage extends StatelessWidget {
  const SpinnerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DemoSection(
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
        const SizedBox(height: 24),
        DemoSection(
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
      ],
    );
  }
}
