import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:example/widgets/toggle.dart';

class TogglePage extends StatefulWidget {
  const TogglePage({super.key});

  @override
  State<TogglePage> createState() => _TogglePageState();
}

class _TogglePageState extends State<TogglePage> {
  bool _default1 = false;
  bool _default2 = true;
  bool _small1 = false;
  bool _small2 = true;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSection(
            title: 'Default',
            child: Row(
              children: [
                Toggle(
                  value: _default1,
                  onChanged: (v) => setState(() => _default1 = v),
                ),
                const SizedBox(width: 16),
                Toggle(
                  value: _default2,
                  onChanged: (v) => setState(() => _default2 = v),
                ),
              ],
            ),
          ),
          _buildSection(
            title: 'Small',
            child: Row(
              children: [
                Toggle.small(
                  value: _small1,
                  onChanged: (v) => setState(() => _small1 = v),
                ),
                const SizedBox(width: 16),
                Toggle.small(
                  value: _small2,
                  onChanged: (v) => setState(() => _small2 = v),
                ),
              ],
            ),
          ),
          _buildSection(
            title: 'Disabled',
            child: Row(
              children: [
                const Toggle(value: false),
                const SizedBox(width: 16),
                const Toggle(value: true),
              ],
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
