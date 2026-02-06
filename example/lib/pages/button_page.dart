import 'package:flutter/material.dart';
import 'package:example/widgets/button.dart';

class ButtonPage extends StatefulWidget {
  const ButtonPage({super.key});

  @override
  State<ButtonPage> createState() => _ButtonPageState();
}

class _ButtonPageState extends State<ButtonPage> {
  bool _loading = false;

  void _simulateLoading() async {
    setState(() => _loading = true);
    await Future.delayed(const Duration(seconds: 2));
    setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSection(
          title: 'Variants',
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              Button.small(
                onPressed: () {},
                label: 'Primary',
                variant: ButtonVariant.primary,
              ),
              Button.small(
                onPressed: () {},
                label: 'Secondary',
                variant: ButtonVariant.secondary,
              ),
              Button.small(
                onPressed: () {},
                label: 'Destructive',
                variant: ButtonVariant.destructive,
              ),
              Button.small(
                onPressed: () {},
                label: 'Outline',
                variant: ButtonVariant.outline,
              ),
              Button.small(
                onPressed: () {},
                label: 'Ghost',
                variant: ButtonVariant.ghost,
              ),
              Button.small(
                onPressed: () {},
                label: 'Link',
                variant: ButtonVariant.link,
              ),
            ],
          ),
        ),
        _buildSection(
          title: 'Sizes',
          child: Row(
            children: [
              Expanded(
                child: Button(
                  onPressed: () {},
                  label: 'Default size',
                ),
              ),
              const SizedBox(width: 12),
              Button.small(
                onPressed: () {},
                label: 'Small size',
              ),
            ],
          ),
        ),
        _buildSection(
          title: 'With icon',
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              Button.small(
                onPressed: () {},
                label: 'Settings',
                icon: const Icon(Icons.settings),
              ),
              Button.small(
                onPressed: () {},
                label: 'Delete',
                icon: const Icon(Icons.delete),
                variant: ButtonVariant.destructive,
              ),
              Button.small(
                onPressed: () {},
                label: 'Add new',
                icon: const Icon(Icons.add),
                variant: ButtonVariant.outline,
              ),
            ],
          ),
        ),
        _buildSection(
          title: 'Loading state',
          child: Row(
            children: [
              Button.small(
                onPressed: _simulateLoading,
                label: _loading ? 'Loading...' : 'Click to load',
                loading: _loading,
              ),
            ],
          ),
        ),
        _buildSection(
          title: 'Disabled state',
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              Button.small(
                onPressed: null,
                label: 'Primary',
                variant: ButtonVariant.primary,
              ),
              Button.small(
                onPressed: null,
                label: 'Secondary',
                variant: ButtonVariant.secondary,
              ),
              Button.small(
                onPressed: null,
                label: 'Destructive',
                variant: ButtonVariant.destructive,
              ),
              Button.small(
                onPressed: null,
                label: 'Outline',
                variant: ButtonVariant.outline,
              ),
              Button.small(
                onPressed: null,
                label: 'Ghost',
                variant: ButtonVariant.ghost,
              ),
              Button.small(
                onPressed: null,
                label: 'Link',
                variant: ButtonVariant.link,
              ),
            ],
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
